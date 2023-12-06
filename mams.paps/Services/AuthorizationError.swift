

import Foundation

enum AuthorizationError: Error {
    case invalidCredentials
    case emptyLogin
    case emptyPassword

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
