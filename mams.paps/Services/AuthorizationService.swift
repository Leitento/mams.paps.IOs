

import Foundation

protocol AuthorizationServiceProtocol {
    func checkCredentials(login: String, password: String, completion: @escaping (Bool, String?) -> Void)
}

final class AuthorizationService {
    private let validUser: User = User(login: "user", password: "password")
}

    //MARK: - AuthorizationServiceProtocol
extension AuthorizationService: AuthorizationServiceProtocol {

    func checkCredentials(login: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        if (login == validUser.login) && (password == validUser.password) {
            completion(true, nil)
        } else {
            completion(false, "Не правильный пароль")
        }
    }
}
