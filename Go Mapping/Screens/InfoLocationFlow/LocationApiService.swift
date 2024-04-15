//
//  LocationApiService.swift
//  mams.paps
//
//  Created by Kos on 07.03.2024.
//

import Foundation

protocol LocationApiServiceProtocol {
    func getCategoryes() async throws -> [Category]
    func getLocations() async throws -> [Location]
}

final class LocationApiService {
    
    private let mapper: CoreMapperProtocol
    private let networkManager: CoreNetworkManager
    
    init(mapper: CoreMapperProtocol, networkManager: CoreNetworkManager) {
        self.mapper = mapper
        self.networkManager = networkManager
    }
}

extension LocationApiService: LocationApiServiceProtocol {
    func getCategoryes() async throws -> [Category] {
        let data = try await networkManager.getRequest(enterPoint: .categoryes)
        let categories = try await mapper.map(from: data, jsonType: [Categoryes].self)
        return categories.map { Category(category: $0) }
    }
    
    func getLocations() async throws -> [Location] {
        let data = try await networkManager.getRequest(enterPoint: .locations)
        let locations = try await mapper.map(from: data, jsonType: PlaygroundModel.self)
        return locations.playgrounds.map { Location(location: $0) }
    }
    
}
