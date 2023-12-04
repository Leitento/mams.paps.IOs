

import Foundation

protocol AuthorizationServiceProtocol {
    func checkCredentials(login: String, password: String, completion: @escaping (Bool) -> Void)
}

final class AuthorizationService {
    private let validUser: User = User(login: "user", password: "password")
}

    //MARK: - AuthorizationServiceProtocol
extension AuthorizationService: AuthorizationServiceProtocol {

    func checkCredentials(login: String, password: String, completion: @escaping (Bool) -> Void) {
        let isValid = (login == validUser.login) && (password == validUser.password)
        completion(isValid)
    }
}
