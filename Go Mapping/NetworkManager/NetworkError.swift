//
//  NetworkError.swift
//  mams.paps
//
//  Created by Kos on 07.03.2024.
//

import Foundation

enum NetworkError: Error {
    case noInternet
    case noData
    case somethingWentWrong
    
    var errorDescription: String {
        switch self {
        case .noInternet:
            return "notInternet".localized
        case .noData:
            return "notData".localized
        case .somethingWentWrong:
            return "somethingWentWrong".localized
        }
    }
}
