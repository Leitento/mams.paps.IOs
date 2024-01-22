

import UIKit

protocol MainScreenCoordinatorProtocol: AnyObject {
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
    var navigationController: UINavigationController
    
    // MARK: - Private Properties
    private var user: User?
    
    // MARK: - Private method
    private func createNavigationController() -> UIViewController {
        let viewModel = MainViewModel(user: user, coordinator: self)
        let mainViewController = MainViewController(viewModel: viewModel)
        let navController = UINavigationController(rootViewController: mainViewController)
        self.navigationController = navController
        return navigationController
    }
    
    private func addChildCoordinator(_ coordinator: CoordinatorProtocol) {
        childCoordinators.append(coordinator)
    }
    
    // MARK: - Life Cycle
    init(user: User?, parentCoordinator: AppCoordinatorProtocol, navigationController: UINavigationController) {
        self.user = user
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
    }
}

// MARK: - CoordinatorProtocol
extension MainScreenCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        createNavigationController()
    }
}

// MARK: - AuthorizationCoordinatorDelegate
extension MainScreenCoordinator: MainScreenCoordinatorProtocol {
    
    func mainCoordinatorDidFinish() {
    }
    
    func showAuthorizationScreen() {
        print("showAuthorizationScreen")
        let profileCoordinator = ProfileScreenCoordinator(user: user, parentCoordinator: self)
        addChildCoordinator(profileCoordinator)
        let viewController = profileCoordinator.start()
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func presentAvailableCities() {
        print("presentAvailableCities")
    }
    
    func pushMapScreen() {
        print("pushMapScreen")
    }
    
    func pushEventsScreen() {
        print("pushEventsScreen")
    }
    
    func pushServicesScreen() {
        print("pushServicesScreen")
    }
    
    func pushUsefulScreen() {
        print("pushUsefulScreen")
    }
    
    
}
