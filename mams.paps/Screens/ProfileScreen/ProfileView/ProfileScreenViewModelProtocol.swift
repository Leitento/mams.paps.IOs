//
//  ProfileScreenViewModelProtocol.swift
//  mams.paps
//
//  Created by Юлия Кагирова on 21.01.2024.
//

import UIKit

protocol ProfileScreenViewModelProtocol: AnyObject {
    
    func showProfileScreen()
    func pushProfileEditingButton()
    func pushAddButton()
    func pushFavouritesButton()
    func pushNotificationButton()
    func pushContactOfferButton()
    func pushAboutAppButton()
    func pushSupportButton()
    func pushLogoutButton()
}

final class ProfileScreenViewModel {
    
    //MARK: - Properties
    
    var currentUser: User?
    
    //MARK: - Private Properties
    
    private let coordinator: ProfileCoordinatorProtocol
    
    
    //MARK: - Life Cycles
    
    init(user: User?, coordinator: ProfileCoordinatorProtocol) {
        self.currentUser = user
        self.coordinator = coordinator
    }
}

extension ProfileScreenViewModel: ProfileScreenViewModelProtocol {
    func showProfileScreen() {
        coordinator.showProfileScreen()
    }
    func pushProfileEditingButton() {
        coordinator.pushProfileEditingButton()
    }
    func pushAddButton() {
        coordinator.pushBannerButton()
    }
    func pushFavouritesButton() {
        coordinator.pushFavouritesButton()
    }
    func pushNotificationButton() {
        coordinator.pushNotificationButton()
    }
    func pushContactOfferButton() {
        coordinator.pushContactOfferButton()
    }
    func pushAboutAppButton() {
        coordinator.pushAboutAppButton()
    }
    func pushSupportButton() {
        coordinator.pushSupportButton()
    }
    func pushLogoutButton() {
        coordinator.pushLogoutButton()
    }
}

