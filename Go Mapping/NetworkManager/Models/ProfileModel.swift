//
//  ProfileUser.swift
//  mams.paps
//
//  Created by Юлия Кагирова on 19.03.2024.
//

import Foundation

struct ProfileEditJson: Codable {
    let id: Int
    let name: String
    let secondName: String
    let city: String
    let email: String
    let teleptone: String
    let dateOfBirth: String
    let avatar: String
}
