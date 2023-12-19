

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
    var navigationController: UINavigationController?
    
    // MARK: - Private Properties
    private var user: User?
    
    // MARK: - Private method
    private func createNavigationController() -> UIViewController {
        let viewModel = MainViewModel(user: user, coordinator: self)
        let mainViewController = MainViewController(viewModel: viewModel)
        return mainViewController
    }
    
    // MARK: - Life Cycle
    init(user: User?, parentCoordinator: AppCoordinatorProtocol) {
        self.user = user
        self.parentCoordinator = parentCoordinator
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
