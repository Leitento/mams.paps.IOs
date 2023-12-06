

import UIKit

protocol MainCoordinatorDelegate: AnyObject {
    func mainCoordinatorDidFinish()
    func pushMapScreen()
    func pushEventsScreen()
    func pushServicesScreen()
    func pushUsefulScreen()
}

final class MainCoordinator {
    
    // MARK: - Properties
    weak var delegate: MainCoordinatorDelegate?
    
    // MARK: - Private methods
    private func createNavigationController() -> UIViewController {
        return UIViewController()
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
