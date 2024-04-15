

import Foundation

enum AuthorizationError: Error {
    case invalidCredentials
    case emptyLogin
    case emptyPassword

    // MARK: - Properties
    var description: String {
        switch self {
        case .invalidCredentials:
            return "AuthorizationError.InvalidCredentials".localized
        case .emptyLogin:
            return "AuthorizationError.EmptyLogin".localized
        case .emptyPassword:
            return "AuthorizationError.EmptyPassword".localized
        }
    }
}
