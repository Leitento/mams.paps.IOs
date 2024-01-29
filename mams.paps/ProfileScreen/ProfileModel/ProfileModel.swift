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
    let name: String
    let secondName: String
    let city: String
    let email: String
}

struct BannerModel: Hashable {
    let banner: UIImage?
}

struct ButtonsModel: Hashable {
    var icon: UIImage?
    var title: String
}

enum ButtonsTitles {
    static let favourites = "ProfileCell.favourite".localized 
    static let notifications = "ProfileCell.notification".localized
    static let contractOffer = "ProfileCell.contractOffer".localized
    static let aboutApp = "ProfileCell.aboutApp".localized
    static let support = "ProfileCell.support".localized
    static let logout = "ProfileCell.logout".localized
}

enum Icon {
    static let favourite = UIImage(named: "favourite")
    static let notification = UIImage(named: "notification")
    static let contractOffer = UIImage(named: "contractOffer")
    static let aboutApp = UIImage(named: "aboutApp")
    static let support = UIImage(named: "support")
    static let logout = UIImage(named: "logout")
    
}

extension ButtonsModel {
    static func makeButtons() -> [Self] {
        [
            ButtonsModel(icon: Icon.favourite, title: ButtonsTitles.favourites),
            .init(icon: Icon.notification!, title: ButtonsTitles.notifications),
            .init(icon: Icon.contractOffer!, title: ButtonsTitles.contractOffer),
            .init(icon: Icon.aboutApp!, title: ButtonsTitles.aboutApp),
            .init(icon: Icon.support!, title: ButtonsTitles.support),
            .init(icon: Icon.logout!, title: ButtonsTitles.logout)
        ]
    }
}
