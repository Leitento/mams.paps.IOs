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
    static let favourires = "Избранное"
    static let notifications = "Уведомления"
    static let contractOffer = "Публичная Оферта"
    static let aboutApp = "О приложении"
    static let support = "Поддержка MamsPaps"
    static let logout = "Выйти из аккаунта"
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
            ButtonsModel(icon: Icon.favourite, title: ButtonsTitles.favourires),
            .init(icon: Icon.notification!, title: ButtonsTitles.notifications),
            .init(icon: Icon.contractOffer!, title: ButtonsTitles.contractOffer),
            .init(icon: Icon.aboutApp!, title: ButtonsTitles.aboutApp),
            .init(icon: Icon.support!, title: ButtonsTitles.support),
            .init(icon: Icon.logout!, title: ButtonsTitles.logout)
        ]
    }
}
