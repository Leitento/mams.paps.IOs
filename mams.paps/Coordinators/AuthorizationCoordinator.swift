

import UIKit

protocol AuthorizationCoordinatorProtocol: AnyObject {
    func authorizationCoordinatorDidFinish()
}

final class AuthorizationCoordinator {
    
    // MARK: - Properties
    weak var parentCoordinator: AppCoordinatorProtocol?
    
    init(parentCoordinator: AppCoordinatorProtocol?) {
        self.parentCoordinator = parentCoordinator
    }
    
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
extension AuthorizationCoordinator: AuthorizationCoordinatorProtocol {
    func authorizationCoordinatorDidFinish() {
        parentCoordinator?.switchToNextBranch(from: self)
    }
}
