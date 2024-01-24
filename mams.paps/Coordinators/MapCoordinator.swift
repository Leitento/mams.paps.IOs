

import UIKit

final class MapCoordinator {
    
    weak var parentCoordinator: CoordinatorProtocol?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController, parentCoordinator: CoordinatorProtocol) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    private func createNavigationController() -> UIViewController {
//        let viewModel = MapViewModel(coordinator: self)
        let mapViewController = YandexMapViewController()
        let navigationController = UINavigationController(rootViewController: mapViewController)
        navigationController.tabBarItem = UITabBarItem(title: "Map.Title".localized, image: UIImage(systemName: "map"), tag: 1)
        self.navigationController = navigationController
        return navigationController
    }
    
}

extension MapCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        createNavigationController()
    }
}
