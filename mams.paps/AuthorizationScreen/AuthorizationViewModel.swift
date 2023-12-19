

import Foundation

protocol AuthorizationViewModelProtocol: AnyObject {
    var stateChanger: ((AuthorizationViewModel.State) -> Void)? { get set }
    func presentRestorePasswordController()
    func presentSignUpController()
    func showMainScreenForGuest()
    func showMainScreenForUser(for user: User?)
    func authenticateUser(login: String, password: String)
}

final class AuthorizationViewModel {
    
    enum State {
        case withoutLogin
        case errorLogin(error: String)
        case loginSuccess(user: User)
    }
    
    //MARK: - Private Properties
    private let coordinator: AuthorizationCoordinatorProtocol
    private let authorizationService: AuthorizationServiceProtocol
    
    //MARK: - Properties
    var stateChanger: ((State) -> Void)?
    
    private var state: State = .withoutLogin {
        didSet {
            self.stateChanger?(state)
        }
    }
    
        
    //MARK: - Life Cycles
    init(coordinator: AuthorizationCoordinatorProtocol, authorizationService: AuthorizationServiceProtocol) {
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
    
    func showMainScreenForGuest() {
        coordinator.authorizationCoordinatorDidFinish(user: nil)
    }
    
    func showMainScreenForUser(for user: User?) {
        coordinator.authorizationCoordinatorDidFinish(user: user)
    }
    
    func authenticateUser(login: String, password: String) {
        authorizationService.checkCredentials(login: login, password: password) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let user):
                self.state = .loginSuccess(user: user)
            case .failure(let error):
                self.state = .errorLogin(error: error.description)
            }
        }
    }
}
