

import Combine
import UIKit
import YandexMapsMobile

protocol MapViewControllerDelegate: AnyObject {
    
}

final class MapViewController: UIViewController, MapViewControllerDelegate {
    
    // MARK: - Private properties
    var viewModel: MapViewModel
    var currentLocation: Coordinates?
    
    private let searchBarController = UISearchController()
    private var bag = Set<AnyCancellable>()
    
    private lazy var mapView = MapView(frame: view.bounds, controller: self)
    
    // MARK: - Life Cycle
    init(viewModel: MapViewModelProtocol) {
        self.viewModel = viewModel as! MapViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchCurrentLocation { result in
            switch result {
            case .success(let coordinates):
                self.currentLocation = coordinates
            case .failure(let error):
                Alert.shared.showAlert(on: self, title: "Error", message: error.description)
            }
        }
        
        setupView()
        setupSearchController()
        viewModel.setupSubscriptions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Private methods
    
    private func setupView() {
        view.addSubviews(mapView, translatesAutoresizingMaskIntoConstraints: false)
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func setupSearchController() {
        
        searchBarController.searchResultsUpdater = self
        searchBarController.obscuresBackgroundDuringPresentation = true
        searchBarController.hidesNavigationBarDuringPresentation = false
        searchBarController.searchBar.placeholder = "SearchBar.Placeholder".localized

        navigationItem.searchController = searchBarController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false

        searchBarController.delegate = self
        searchBarController.searchBar.delegate = self
        searchBarController.searchBar.showsBookmarkButton = false

        setupStateUpdates()
    }
    
    private func displaySearchResults(
        items: [SearchResponseItem],
        zoomToItems: Bool,
        itemsBoundingBox: YMKBoundingBox
    ) {
        mapView.displaySearchResults(items: items, zoomToItems: zoomToItems, itemsBoundingBox: itemsBoundingBox)
    }
    
    private func focusCamera(points: [YMKPoint], boundingBox: YMKBoundingBox) {
        if points.isEmpty {
            return
        }
        mapView.focusCamera(points: points, boundingBox: boundingBox)
    }
    
    // MARK: - Methods

}

extension MapViewController: UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.reset()
        viewModel.setQueryText(with: searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.startSearch(with: nil)
        searchBarController.searchBar.text = viewModel.mapUIState.query
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if case .idle = viewModel.mapUIState.searchState {
            updatePlaceholder()
        }
    }

    func updateSearchResults(for searchController: UISearchController, selecting searchSuggestion: UISearchSuggestion) {
        guard let item = searchSuggestion.representedObject as? SuggestItem else {
            return
        }

        item.onClick()
    }

    func setupStateUpdates() {
        viewModel.$mapUIState.sink { [weak self] state in
            let query = state?.query ?? String()
            self?.searchBarController.searchBar.text = query
            self?.updatePlaceholder(with: query)

            if case let .success(items, zoomToItems, itemsBoundingBox) = state?.searchState {
                self?.displaySearchResults(items: items, zoomToItems: zoomToItems, itemsBoundingBox: itemsBoundingBox)
                if zoomToItems {
                    self?.focusCamera(points: items.map { $0.point }, boundingBox: itemsBoundingBox)
                }
            }
            if let suggestState = state?.suggestState {
                self?.updateSuggests(with: suggestState)
            }
        }
        .store(in: &bag)
    }

    private func updateSuggests(with suggestState: SuggestState) {
        switch suggestState {
        case .success(let items):
            searchBarController.searchSuggestions = items.map { item in
                let title = AttributedString(item.title.text)
                let subtitle = AttributedString(item.subtitle?.text ?? "")
                    .settingAttributes(
                        AttributeContainer([.foregroundColor: UIColor.secondaryLabel])
                    )

                let suggestString = NSAttributedString(title + AttributedString(" ") + subtitle)

                let suggest = UISearchSuggestionItem(localizedAttributedSuggestion: suggestString)
                suggest.representedObject = item
                return suggest
            }

        default:
            return
        }
    }

    private func updatePlaceholder(with text: String = String()) {
        searchBarController.searchBar.placeholder = text.isEmpty ? "SearchBar.Placeholder".localized : text
    }
}
    
