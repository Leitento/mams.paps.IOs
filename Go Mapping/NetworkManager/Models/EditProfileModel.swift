//
//  EditProfileModel.swift
//  mams.paps
//
//  Created by Юлия Кагирова on 19.03.2024.
//

import UIKit

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

