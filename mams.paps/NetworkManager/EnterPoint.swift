//
//  EnterPoint.swift
//  mams.paps
//
//  Created by Kos on 07.03.2024.
//

import Foundation

enum EnterPoint {
    case locations
    case categoryes
    case profile
    
    var urlRequest: URLRequest {
        switch self {
        case .locations:
            return URLRequest(url: URL(string: "https://mocki.io/v1/0ece1421-7975-4422-b951-5f03af7d3d2a")!)
        case .categoryes:
            return URLRequest(url: URL(string: "https://mocki.io/v1/1113e205-fe1a-457f-9ce2-ab9fc9f6f8b4")!)
        case .profile:
            return URLRequest(url: URL(string: "https://run.mocky.io/v3/67c96135-95b7-419e-9188-d6acb1407aa6")!)
        }
    }
}
