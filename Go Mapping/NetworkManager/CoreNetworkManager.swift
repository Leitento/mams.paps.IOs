//
//  CoreNetworkManager.swift
//  mams.paps
//
//  Created by Kos on 07.03.2024.
//

import Foundation


protocol NetworkManagerProtocol {
    func getRequest(enterPoint: EnterPoint) async throws -> Data
}

final class CoreNetworkManager { }

extension CoreNetworkManager: NetworkManagerProtocol {

    func getRequest(enterPoint: EnterPoint) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(for: enterPoint.urlRequest)

        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.noInternet
        }
        print("http status code: (response.statusCode)")
        return data

    }
}
