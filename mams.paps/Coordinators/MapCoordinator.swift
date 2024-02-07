

import UIKit

protocol MapCoordinatorProtocol: AnyObject {
    
}

final class MapCoordinator {
    
    // MARK: - Properties
    weak var parentCoordinator: CoordinatorProtocol?
    var navigationController: UINavigationController
    var locationService: LocationServiceProtocol
    
    // MARK: - Life Cycle
    init(navigationController: UINavigationController, parentCoordinator: CoordinatorProtocol, locationService: LocationServiceProtocol) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
        self.locationService = LocationService()
    }
    
    // MARK: - Private methods
    private func createNavigationController() -> UIViewController {
        let viewModel = MapViewModel(locationService: locationService, coordinator: self)
        let mapViewController = MapViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: mapViewController)
        navigationController.tabBarItem = UITabBarItem(title: "Map.Title".localized, image: UIImage(systemName: "map"), tag: 2)
        self.navigationController = navigationController
        return navigationController
    }
    
}

// MARK: - CoordinatorProtocol
extension MapCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        createNavigationController()
    }
}

// MARK: - MapCoordinatorProtocol
extension MapCoordinator: MapCoordinatorProtocol {
    
}
