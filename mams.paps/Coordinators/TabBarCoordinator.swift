

import UIKit

protocol TabBarCoordinatorProtocol: AnyObject {
    func switchToNextFlow()
}

final class TabBarCoordinator {
    
    private weak var parentCoordinator: MainScreenCoordinatorProtocol?
    
    private var tabBarController: UITabBarController
    
    private var childCoordinators: [CoordinatorProtocol] = []
    
    init(parentCoordinator: MainScreenCoordinatorProtocol, tabBarController: UITabBarController) {
        self.parentCoordinator = parentCoordinator
        self.tabBarController = tabBarController
    }
    
    private func createTabBar() -> UIViewController {
        
        let tabBarController = UITabBarController()
        
        let mapCoordinator = MapCoordinator(navigationController: UINavigationController(), parentCoordinator: self)
        addChildCoordinator(mapCoordinator)
        
        let controllers = [
            mapCoordinator.start()
        ]
        
        tabBarController.viewControllers = controllers
        self.tabBarController = tabBarController
        
        return tabBarController
    }
    
    private func addChildCoordinator(_ coordinator: CoordinatorProtocol) {
        childCoordinators.append(coordinator)
    }
    
    private func removeChildCoordinator(_ coordinator: CoordinatorProtocol) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
    
}

extension TabBarCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        createTabBar()
    }
}

extension TabBarCoordinator: TabBarCoordinatorProtocol {
    func switchToNextFlow() {
        self.parentCoordinator?.switchToNextBranch(from: self)
    }
    
    
}
