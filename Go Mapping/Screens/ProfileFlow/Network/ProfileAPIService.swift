//
//  ProfileAPIService.swift
//  mams.paps
//
//  Created by Юлия Кагирова on 19.03.2024.
//

import Foundation

protocol ProfileAPIServiceProtocol {
    func getProfile() async throws -> ProfileUser 
}

final class ProfileAPIService {
    private let mapper: CoreMapperProtocol
    private let networkManager: CoreNetworkManager
    
    init(mapper: CoreMapperProtocol, networkManager: CoreNetworkManager) {
        self.mapper = mapper
        self.networkManager = networkManager
    }

}

extension ProfileAPIService: ProfileAPIServiceProtocol {
    func getProfile() async throws -> ProfileUser {
        let data = try await networkManager.getRequest(enterPoint: .profile)
        let profile = try await mapper.map(from: data, jsonType: ProfileEditJson.self)
        return ProfileUser(profile: profile)
    }
    
    
}
