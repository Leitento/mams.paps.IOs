

import UIKit

final class MapCoordinator {
    
    // MARK: - Properties
    weak var parentCoordinator: CoordinatorProtocol?
    var navigationController: UINavigationController
    
    // MARK: - Life Cycle
    init(navigationController: UINavigationController, parentCoordinator: CoordinatorProtocol) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    // MARK: - Private methods
    private func createNavigationController() -> UIViewController {
//        let viewModel = MapViewModel(coordinator: self)
        let mapViewController = MapViewController(/*viewModel: viewModel*/)
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
