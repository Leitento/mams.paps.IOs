//
//  ProfileModel.swift
//  mams.paps
//
//  Created by Юлия Кагирова on 21.12.2023.
//

import UIKit

struct Profile: Hashable {
    let profileModel: ProfileModel
    let bannerModel: BannerModel
    let buttonsModel: [ButtonsModel]
}

struct ProfileModel: Hashable {
    let id: Int
    let name: String
    let secondName: String
    let city: String
    let email: String
    let telephone: String
    let dateOfBirth: String
    let avatar: String
    
    init (
        id: Int,
        name: String,
        secondName: String,
        city: String,
        email: String,
        telephone: String,
        dateOfBirth: String,
        avatar: String
    ) {
        self.id = id
        self.name = name
        self.secondName = secondName
        self.city = city
        self.email = email
        self.telephone = telephone
        self.dateOfBirth = dateOfBirth
        self.avatar = avatar
    }
}

struct BannerModel: Hashable {
    let banner: UIImage?
}

struct ButtonsModel: Hashable {
    var icon: UIImage?
    var title: String
    var target: ButtonsTarget
}

enum ButtonsTarget {
    case favourites
    case myAdvertising
    case notifications
    case contractOffer
    case aboutApp
    case support
    case logout
}

enum ButtonsTitles {
    static let favourites = "ProfileCell.favourite".localized
    static let myAdds = "ProfileCell.myAdds".localized
    static let notifications = "ProfileCell.notification".localized
    static let contractOffer = "ProfileCell.contractOffer".localized
    static let aboutApp = "ProfileCell.aboutApp".localized
    static let support = "ProfileCell.support".localized
    static let logout = "ProfileCell.logout".localized
}

enum Icon {
    static let favourite = UIImage(named: "favourite")
    static let myAdds = UIImage(named: "adds")
    static let notification = UIImage(named: "notification")
    static let contractOffer = UIImage(named: "contractOffer")
    static let aboutApp = UIImage(named: "aboutApp")
    static let support = UIImage(named: "support")
    static let logout = UIImage(named: "logout")
}

extension ButtonsModel {
    static func makeButtons() -> [Self] {
        [
            ButtonsModel(icon: Icon.favourite, title: ButtonsTitles.favourites, target: .favourites),
            ButtonsModel(icon: Icon.myAdds!, title: ButtonsTitles.myAdds, target: .myAdvertising),
            ButtonsModel(icon: Icon.notification!, title: ButtonsTitles.notifications, target: .notifications),
            ButtonsModel(icon: Icon.contractOffer!, title: ButtonsTitles.contractOffer, target: .contractOffer),
            ButtonsModel(icon: Icon.aboutApp!, title: ButtonsTitles.aboutApp, target: .aboutApp),
            ButtonsModel(icon: Icon.support!, title: ButtonsTitles.support, target: .support),
            ButtonsModel(icon: Icon.logout!, title: ButtonsTitles.logout, target: .logout)
        ]
    }
}

extension ProfileModel {
    init(profile: ProfileEditJson) {
        self.id = profile.id
        self.name = profile.name
        self.secondName = profile.secondName
        self.city = profile.city
        self.email = profile.email
        self.telephone = profile.teleptone
        self.dateOfBirth = profile.dateOfBirth
        self.avatar = profile.avatar
    }
}
