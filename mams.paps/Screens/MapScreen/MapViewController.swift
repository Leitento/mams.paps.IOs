

import Combine
import UIKit
import YandexMapsMobile

protocol MapViewControllerDelegate: AnyObject {
    
}

final class MapViewController: UIViewController, MapViewControllerDelegate {
    
    // MARK: - Properties
    var currentLocation: Coordinates?
    
    // MARK: - Private Properties

    private lazy var mapView = MapView(frame: view.bounds, controller: self)
    private var viewModel: MapViewModel
    
    private var searchBarController: UISearchController?
    private var bag = Set<AnyCancellable>()
    @Published private var searchSuggests: [SuggestItem] = []
    private lazy var mapObjectTapListener = MapObjectTapListener(controller: self)
    
    // MARK: - Life Cycle
    init(viewModel: MapViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarController = mapView.getSearchController()
        viewModel.fetchCurrentLocation { result in
            switch result {
            case .success(let coordinates):
                self.currentLocation = coordinates
            case .failure(let error):
                Alert.shared.showAlert(on: self, title: "Error", message: error.description)
            }
        }
        setupView()
        
        /// настраиваем поиск
        setupStateUpdates()
        viewModel.setupSubscriptions()
        moveToStartPoint()
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
    
    private func moveToStartPoint() {
        guard let map = mapView.map else { return}
        viewModel.setVisibleRegion(with: map.visibleRegion)
    }
    
    private func displaySearchResults(
        items: [SearchResponseItem],
        zoomToItems: Bool,
        itemsBoundingBox: YMKBoundingBox
    ) {
        guard let map = mapView.map else { return}

        map.mapObjects.clear()

        items.forEach { item in
            let image = UIImage(systemName: "circle.circle.fill")!
                .withTintColor(.tintColor)

            let placemark = map.mapObjects.addPlacemark()
            placemark.geometry = item.point
            placemark.setViewWithView(YRTViewProvider(uiView: UIImageView(image: image)))

            placemark.userData = item.geoObject
            placemark.addTapListener(with: mapObjectTapListener)
        }
    }
    
    private func focusCamera(points: [YMKPoint], boundingBox: YMKBoundingBox) {
        guard let map = mapView.map else { return}
        
        if points.isEmpty {
            return
        }

        let position = points.count == 1
            ? YMKCameraPosition(
                target: points.first!,
                zoom: map.cameraPosition.zoom,
                azimuth: map.cameraPosition.azimuth,
                tilt: map.cameraPosition.tilt
            )
            : map.cameraPosition(with: YMKGeometry(boundingBox: boundingBox))

        map.move(with: position, animation: YMKAnimation(type: .smooth, duration: 0.5))
    }
}

//MARK: - UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate
extension MapViewController: UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.reset()
        viewModel.setQueryText(with: searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.startSearch(with: nil)
        searchBarController?.searchBar.text = viewModel.mapUIState.query
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
            guard let self else { return }
            let query = state?.query ?? String()
            searchBarController?.searchBar.text = query
            updatePlaceholder(with: query)

            if case let .success(items, zoomToItems, itemsBoundingBox) = state?.searchState {
                displaySearchResults(items: items, zoomToItems: zoomToItems, itemsBoundingBox: itemsBoundingBox)
                if zoomToItems {
                    focusCamera(points: items.map { $0.point }, boundingBox: itemsBoundingBox)
                }
            }
            if let suggestState = state?.suggestState {
                updateSuggests(with: suggestState)
            }
        }
        .store(in: &bag)
    }

    private func updateSuggests(with suggestState: SuggestState) {
        switch suggestState {
        case .success(let items):
            searchBarController?.searchSuggestions = items.map { item in
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
        searchBarController?.searchBar.placeholder = text.isEmpty ? "Search places" : text
    }
}
