

import Foundation

enum LocationServiceError: Error {
    case authorizationDenied
    case locationUnavailable
    
    // MARK: - Properties
    var description: String {
        switch self {
        case .authorizationDenied:
            return "LocationServiceError.AuthorizationDenied".localized
        case .locationUnavailable:
            return "LocationServiceError.LocationUnavailable".localized
        }
    }
}
