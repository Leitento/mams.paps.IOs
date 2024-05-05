

import UIKit
import YandexMapsMobile

protocol MapViewControllerDelegate: AnyObject {
    
}

final class MapViewController: UIViewController, MapViewControllerDelegate {
    
    // MARK: - Properties
    var currentLocation: Coordinates?
    
    // MARK: - Private Properties

    private lazy var mapView = MapView(frame: view.bounds, controller: self)
    private var viewModel: MapViewModelProtocol
    
    // MARK: - Life Cycle
    init(viewModel: MapViewModelProtocol) {
        self.viewModel = viewModel
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
                Alert.shared.showAlert(on: self, title: "AlertTitle.Error".localized, message: error.description)
            }
        }
        setupView()
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
    
    private func presentFilterSettings(itemIndex: Int) {
        let filterSettingsViewModel = FiltersSettingsViewModel(selectedItemIndex: itemIndex)
        let filterSettingsViewController = FilterSettingsViewController(viewModel: filterSettingsViewModel)
        navigationController?.pushViewController(filterSettingsViewController, animated: true)
    }
    
    func presentPopup() {
        let popupViewController = PopupViewController { popupMenuItemIndex in
            self.presentFilterSettings(itemIndex: popupMenuItemIndex)
        }
        navigationController?.modalPresentationStyle = .popover
        navigationController?.modalTransitionStyle = .coverVertical
        navigationController?.present(popupViewController, animated: true)
    }
    
    func searchText(with searchText: String) {
        viewModel.reset()
        viewModel.setQueryText(with: searchText)
    }
}
