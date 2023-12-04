

import Foundation

protocol AuthorizationViewModelProtocol: AnyObject {
    func pushMainController()
    func authenticateUser(user: User)
    func presentRestorePasswordController()
    func presentSignUpController()
}

final class AuthorizationViewModel {
    
    //MARK: - Private Properties
    private let coordinator: AuthorizationCoordinatorDelegate
    private let authorizationService: AuthorizationServiceProtocol
    
    //MARK: - Properties
    var authorizationViewController: AuthorizationViewController?
        
    //MARK: - Life Cycles
    init(coordinator: AuthorizationCoordinatorDelegate, authorizationService: AuthorizationServiceProtocol) {
        self.coordinator = coordinator
        self.authorizationService = authorizationService
    }
}

    //MARK: - AuthorizationViewModelProtocol
extension AuthorizationViewModel: AuthorizationViewModelProtocol {
    func presentRestorePasswordController() {
        print("Показать экран восстановления пароля")
    }
    
    func presentSignUpController() {
        print("Показать экран регистрации")
    }
    
    func pushMainController() {
        coordinator.authorizationCoordinatorDidFinish()
        print("ShowMainScreen")
    }
    
    func authenticateUser(user: User) {
        authorizationService.checkCredentials(login: user.login, password: user.password) { [weak self] isValid in
            guard let self else { return }
            if isValid {
                coordinator.authorizationCoordinatorDidFinish()
            } else {
                guard let authorizationViewController else { return }
                Alert().showAlert(on: authorizationViewController, title: "AuthorizationAlert.title".localized, message: "AuthorizationAlert.message".localized)
            }
        }
    }
}

