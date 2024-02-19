//
//  ProfileViewModel.swift
//  mams.paps
//
//  Created by Юлия Кагирова on 18.01.2024.
//

import UIKit

protocol ProfileViewModelProtocol {
    
    var stateChanger: ((ProfileViewModel.State) -> Void)? { get set }
    func didTappedGetProfile()
    func didTappedEditProfile()
    
    func didTappedFavouriteButton()
    func didTappedNotificationButton()
    func didTappedContactOfferButton()
    func didTappedAboutAppButton()
    func didTappedSupportButton()
    func didTappedLogoutButton()
}

final class ProfileViewModel {
    enum State {
        case loading
        case loaded(profile: Profile)
        case error
    }
    
    //MARK: - Properties
    private weak var coordinator: ProfileCoordinatorProtocol?
    var stateChanger: ((State) -> Void)?
    var state: State = .loading {
        didSet {
            self.stateChanger?(state)
        }
    }
    
    //MARK: - Life Cycle
    
    init(coordinator: ProfileCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    //MARK: - Private Methods
    
    private func getProfile() {
        let profileModel = ProfileModel(name: "name", secondName: "secName", city: "city", email: "mail@gmail.com")
        let bannerModel = BannerModel(banner: UIImage(systemName: "banner"))
        let buttonsModel = ButtonsModel.makeButtons()
        let profile =  Profile(profileModel: profileModel, bannerModel: bannerModel, buttonsModel: buttonsModel)
        state = .loaded(profile: profile)
    }
}

extension ProfileViewModel: ProfileViewModelProtocol {
    func didTappedGetProfile() {
        getProfile()
    }
    func didTappedEditProfile() {
        coordinator?.pushProfileEditingButton()
    }
    func didTappedFavouriteButton() {
        coordinator?.pushFavouritesButton()
    }
    func didTappedNotificationButton() {
        coordinator?.pushNotificationButton()
    }
    func didTappedContactOfferButton() {
        coordinator?.pushContactOfferButton()
    }
    func didTappedAboutAppButton() {
        coordinator?.pushAboutAppButton()
    }
    func didTappedSupportButton() {
        coordinator?.pushSupportButton()
    }
    func didTappedLogoutButton() {
        coordinator?.pushLogoutButton()
//        parentCoordinator.showAuthorizationScreen()
        //back on authorizationScreen
    }
}
