

import UIKit

protocol AuthorizationCoordinatorDelegate: AnyObject {
    func authorizationCoordinatorDidFinish()
}

final class AuthorizationCoordinator {
    
    // MARK: - Properties
    weak var delegate: AuthorizationCoordinatorDelegate?
    
    var authorizationViewController: AuthorizationViewController?
    
    // MARK: - Private methods
    private func createNavigationController() -> UIViewController {
        let authorizationService = AuthorizationService()
        let viewModel = AuthorizationViewModel(coordinator: self, authorizationService: authorizationService)
        let authorizationViewController = AuthorizationViewController(viewModel: viewModel)
        viewModel.authorizationViewController = authorizationViewController
        self.authorizationViewController = authorizationViewController
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
