

import UIKit

protocol AuthorizationCoordinatorDelegate: AnyObject {
    func authorizationCoordinatorDidFinish(user: User?)
}

final class AuthorizationCoordinator {
    
    // MARK: - Properties
    weak var delegate: AuthorizationCoordinatorDelegate?
        
    // MARK: - Private methods
    private func createNavigationController() -> UIViewController {
        let authorizationService = AuthorizationService()
        let viewModel = AuthorizationViewModel(coordinator: self, authorizationService: authorizationService)
        let authorizationViewController = AuthorizationViewController(viewModel: viewModel)
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
    
    func authorizationCoordinatorDidFinish(user: User?) {
        delegate?.authorizationCoordinatorDidFinish(user: user)
    }
}
