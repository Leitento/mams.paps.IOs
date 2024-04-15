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
            return URLRequest(url: URL(string: "https://run.mocky.io/v3/f174e821-b423-4dfc-955a-42fa158b7f6c")!)
        case .categoryes:
            return URLRequest(url: URL(string: "https://run.mocky.io/v3/cf1d1b0d-19f9-43ee-85bc-df4cb98718a6")!)
        case .profile:
            return URLRequest(url: URL(string: "https://mocki.io/v1/e5f1a5ed-4dd8-40b9-ae76-e1555c5ca208" )!)
        }
    }
}
