

import UIKit

protocol MainCoordinatorDelegate: AnyObject {
    func mainCoordinatorDidFinish()
    func showAuthorizationScreen()
    func pushMapScreen()
    func pushEventsScreen()
    func pushServicesScreen()
    func pushUsefulScreen()
    func presentAvailableCities()
}

final class MainCoordinator {
    
    var childCoordinators: [CoordinatorProtocol] = []
    var navigationController: UINavigationController?
    
    // MARK: - Properties
    weak var delegate: MainCoordinatorDelegate?
    private var user: User?
    
    // MARK: - Private methods
    private func createNavigationController() -> UIViewController {
        let viewModel = MainViewModel(user: user, coordinator: self)
        let mainViewController = MainViewController(viewModel: viewModel)
        return mainViewController
    }
    
    // MARK: - Life Cycle
    init(user: User?) {
        self.user = user
    }
}

    // MARK: - CoordinatorProtocol
extension MainCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        createNavigationController()
    }
}

    // MARK: - AuthorizationCoordinatorDelegate
extension MainCoordinator: MainCoordinatorDelegate {
    
    func mainCoordinatorDidFinish() {
        delegate?.mainCoordinatorDidFinish()
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
