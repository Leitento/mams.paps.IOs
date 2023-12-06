

import Foundation

protocol AuthorizationServiceProtocol {
    func checkCredentials(login: String, password: String, completion: @escaping (Result<User, AuthorizationError>) -> Void)
}

final class AuthorizationService {
    private let validUser: User = User(login: "user", password: "password", city: "Москва", userName: "Дмитрий")
}

    //MARK: - AuthorizationServiceProtocol
extension AuthorizationService: AuthorizationServiceProtocol {
    func checkCredentials(login: String, password: String, completion: @escaping (Result<User, AuthorizationError>) -> Void) {
        if (login == validUser.login) && (password == validUser.password) {
            completion(.success(validUser))
        } else if login.isEmpty {
            completion(.failure(.emptyLogin))
        } else if password.isEmpty {
            completion(.failure(.emptyPassword))
        } else {
            completion(.failure(.invalidCredentials))
        }
    }
}

