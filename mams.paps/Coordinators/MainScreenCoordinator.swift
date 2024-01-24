

import UIKit

protocol MainScreenCoordinatorProtocol: AnyObject {
    func switchToNextBranch(from coordinator: CoordinatorProtocol)
    func mainCoordinatorDidFinish()
    func showAuthorizationScreen()
    func pushMapScreen()
    func pushEventsScreen()
    func pushServicesScreen()
    func pushUsefulScreen()
    func presentAvailableCities()
}

final class MainScreenCoordinator {
    
    // MARK: - Properties
    weak var parentCoordinator: AppCoordinatorProtocol?
    var childCoordinators: [CoordinatorProtocol] = []
    var navigationController: UINavigationController?
    var tabBarController = UITabBarController()
    var rootViewController: UIViewController
    
    
    // MARK: - Private Properties
    private var user: UserModel?
    
    private lazy var tabBarCoordinator: CoordinatorProtocol = {
        let tabBarCoordinator = TabBarCoordinator(parentCoordinator: self, tabBarController: tabBarController)
        return tabBarCoordinator
    }()
    
    // MARK: - Life Cycle
    init(parentCoordinator: AppCoordinatorProtocol, rootViewController: UIViewController) {
        self.parentCoordinator = parentCoordinator
        self.rootViewController = rootViewController
        if let username = KeychainService.shared.getUsernameKey() {
            self.user = CoreDataService.shared.getUser(username: username)
        }
    }
    
    // MARK: - Private method
    private func createNavigationController() -> UIViewController {
        let viewModel = MainViewModel(user: user, coordinator: self)
        let mainViewController = MainViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: mainViewController)
        self.navigationController = navigationController
        return navigationController
    }
    
    private func addChildCoordinator(_ coordinator: CoordinatorProtocol) {
        childCoordinators.append(coordinator)
    }
    
    private func removeChildCoordinator(_ coordinator: CoordinatorProtocol) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
    
    private func pushTabBarController() {
        let tabBarCoordinator = TabBarCoordinator(parentCoordinator: self, tabBarController: tabBarController)
        addChildCoordinator(tabBarCoordinator)
        navigationController?.pushViewController(tabBarCoordinator.start(), animated: true)
    }
    
    private func setFlow(to newViewController: UIViewController) {
        rootViewController.addChild(newViewController)
        newViewController.view.frame = rootViewController.view.frame
        rootViewController.view.addSubview(newViewController.view)
        newViewController.didMove(toParent: rootViewController)
    }
    
    private func switchCoordinators(from previousCoordinator: CoordinatorProtocol, to nextCoordinator: CoordinatorProtocol) {
        addChildCoordinator(nextCoordinator)
        switchFlow(to: nextCoordinator.start())
        removeChildCoordinator(previousCoordinator)
    }
    
    private func switchFlow(to newViewController: UIViewController) {
        guard let currentViewController = rootViewController.children.first else {
            return
        }
        
        currentViewController.willMove(toParent: nil)
        currentViewController.navigationController?.isNavigationBarHidden = true
        rootViewController.addChild(newViewController)
        newViewController.view.frame = rootViewController.view.bounds
        
        rootViewController.transition(
            from: rootViewController.children[0],
            to: newViewController,
            duration: 0.5,
            options: [.transitionFlipFromRight]
        ) { [weak self] in
            guard let self else { return }
            currentViewController.removeFromParent()
            newViewController.didMove(toParent: rootViewController)
        }
    }
}

// MARK: - CoordinatorProtocol
extension MainScreenCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        createNavigationController()
    }
}

// MARK: - MainScreenCoordinatorProtocol
extension MainScreenCoordinator: MainScreenCoordinatorProtocol {
    func mainCoordinatorDidFinish() {
        
    }
    
    func showAuthorizationScreen() {
        
    }
    
    func pushMapScreen() {
        switchCoordinators(from: self, to: tabBarCoordinator)
    }
    
    func pushEventsScreen() {
        
    }
    
    func pushServicesScreen() {
        
    }
    
    func pushUsefulScreen() {
        
    }
    
    func presentAvailableCities() {
        
    }
    
    func switchToNextBranch(from coordinator: CoordinatorProtocol) {
//        if coordinator === onboardingCoordinator {
//            switchCoordinators(from: coordinator, to: authorizationCoordinator)
//        } else if coordinator === authorizationCoordinator {
//            markAppAsLaunched()
//            switchCoordinators(from: coordinator, to: mainScreenCoordinator)
//        }
    }
}
    
    
//    func mainCoordinatorDidFinish() {
//    }
//    
//    func showAuthorizationScreen() {
//        print("showAuthorizationScreen")
//    }
//    
//    func presentAvailableCities() {
//        print("presentAvailableCities")
//    }
//    
//    func pushMapScreen() {
//        pushTabBarController()
//        print("pushMapScreen")
//    }
//    
//    func pushEventsScreen() {
//        print("pushEventsScreen")
//    }
//    
//    func pushServicesScreen() {
//        print("pushServicesScreen")
//    }
//    
//    func pushUsefulScreen() {
//        print("pushUsefulScreen")
//    }
//    
//    
//}
