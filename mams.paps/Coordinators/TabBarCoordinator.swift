

import UIKit

protocol TabBarCoordinatorProtocol: AnyObject {
    func pushMapScreen()
    func pushEventsScreen()
    func pushServicesScreen()
    func pushUsefulScreen()
    func showAuthorizationScreen()
}

final class TabBarCoordinator {
    
    // MARK: - Private properties
    private weak var parentCoordinator: AppCoordinatorProtocol?
    
    private var tabBarController: UITabBarController
    
    private var childCoordinators: [CoordinatorProtocol] = []
    
    // MARK: - Life Cycle
    init(parentCoordinator: AppCoordinatorProtocol, tabBarController: UITabBarController) {
        self.parentCoordinator = parentCoordinator
        self.tabBarController = tabBarController
    }
    
    // MARK: - Private methods
    private func createTabBar() -> UIViewController {
        
        let tabBarController = UITabBarController()
        
        let mainScreenCoordinator = MainScreenCoordinator(navigationController: UINavigationController(), parentCoordinator: self)
        addChildCoordinator(mainScreenCoordinator)
        
        let mapCoordinator = MapCoordinator(navigationController: UINavigationController(), parentCoordinator: self)
        addChildCoordinator(mapCoordinator)
        
        let eventsViewController = UIViewController()
        eventsViewController.view.backgroundColor = .white
        eventsViewController.tabBarItem = UITabBarItem(title: "Events", image: UIImage(systemName: "location.circle"), tag: 1)
        
        let servicesViewController = UIViewController()
        servicesViewController.view.backgroundColor = .white
        servicesViewController.tabBarItem = UITabBarItem(title: "Services", image: UIImage(systemName: "plus.circle"), tag: 3)

        
        let profileCoordinator = ProfileScreenCoordinator(user: nil, parentCoordinator: self)
        addChildCoordinator(profileCoordinator)


        let controllers = 
        [
            mainScreenCoordinator.start(),
            eventsViewController,
            mapCoordinator.start(),
            servicesViewController,
            profileCoordinator.start()
        ]
        
        tabBarController.viewControllers = controllers
        tabBarController.tabBar.tintColor = .systemRed
        tabBarController.tabBar.unselectedItemTintColor = .black
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

// MARK: - CoordinatorProtocol
extension TabBarCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        createTabBar()
    }
}

// MARK: - TabBarCoordinatorProtocol
extension TabBarCoordinator: TabBarCoordinatorProtocol {
    func pushMapScreen() {
        if let mapTag = childCoordinators.first(where: { $0 is MapCoordinator })?.start().tabBarItem?.tag {
            print(mapTag)
            tabBarController.animateTabBarTransition(to: mapTag)
        }
    }
    
    func pushEventsScreen() {
        
    }
    
    func pushServicesScreen() {
        
    }
    
    func pushUsefulScreen() {
        
    }
    
    func showAuthorizationScreen() {
        parentCoordinator?.logOut(from: self)
    }
}
