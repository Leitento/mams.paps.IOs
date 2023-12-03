

import UIKit

protocol AuthorizationCoordinatorDelegate: AnyObject {
    func authorizationCoordinatorDidFinish()
}

final class AuthorizationCoordinator {
    
    // MARK: - Properties
    weak var delegate: AuthorizationCoordinatorDelegate?
    
    // MARK: - Private methods
    private func createNavigationController() -> UIViewController {
        let authorizationViewController = AuthorizationViewController()
        return authorizationViewController
    }
}

    // MARK: - CoordinatorProtocol
extension AuthorizationCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        createNavigationController()
    }
}

    // MARK: - AuthorizationCoordinatorDelegate
extension AuthorizationCoordinator: AuthorizationCoordinatorDelegate {
    func authorizationCoordinatorDidFinish() {
        delegate?.authorizationCoordinatorDidFinish()
    }
}
