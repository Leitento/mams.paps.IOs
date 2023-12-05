

import Foundation

protocol AuthorizationViewModelProtocol: AnyObject {
    var stateChanger: ((AuthorizationViewModel.State) -> Void)? { get set }
    func pushMainController()
    func authenticateUser(login: String, password: String)
    func presentRestorePasswordController()
    func presentSignUpController()
    func authSuccess()
}

final class AuthorizationViewModel {
    
    enum State {
        case noLogin
        case errorLogin(error: String?)
        case loginSuccess
    }
    
    //MARK: - Private Properties
    private let coordinator: AuthorizationCoordinatorDelegate
    private let authorizationService: AuthorizationServiceProtocol
    
    //MARK: - Properties
//    var authorizationViewController: AuthorizationViewController?
    var stateChanger: ((State) -> Void)?
    
    private var state: State = .noLogin {
        didSet {
            self.stateChanger?(state)
        }
    }
    
        
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
        coordinator.authorizationCoordinatorDidFinish(user: <#User?#>)
        print("ShowMainScreen")
    }
    
    func authSuccess() {
        coordinator.authorizationCoordinatorDidFinish(user: <#User?#>)
    }
    
    func authenticateUser(login: String, password: String) {
        authorizationService.checkCredentials(login: login, password: password) { [weak self] isValid, error  in
            guard let self else { return }
            if isValid {
                state = .loginSuccess
            } else {
                state = .errorLogin(error: error)
            }
        }
    }
}

