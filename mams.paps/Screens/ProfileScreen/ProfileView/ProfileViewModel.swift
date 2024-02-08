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
    
    func favouriteButton()
    func notificationButton()
    func contactOfferButton()
    func aboutAppButton()
    func supportButton()
    func logoutButton()
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
    //
    private let parentCoordinator: TabBarCoordinatorProtocol
    //
    
    //MARK: - Life Cycle
    
    init(coordinator: ProfileCoordinatorProtocol, parentCoordinator: TabBarCoordinatorProtocol) {
        self.coordinator = coordinator
        self.parentCoordinator = parentCoordinator
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
    func favouriteButton() {
        coordinator?.pushFavouritesButton()
    }
    func notificationButton() {
        coordinator?.pushNotificationButton()
    }
    func contactOfferButton() {
        coordinator?.pushContactOfferButton()
    }
    func aboutAppButton() {
        coordinator?.pushAboutAppButton()
    }
    func supportButton() {
        coordinator?.pushSupportButton()
    }
    func logoutButton() {
        coordinator?.pushLogoutButton()
//        let parentCoordinator = TabBarCoordinatorProtocol()
        parentCoordinator.showAuthorizationScreen()
        //back on authorizationScreen
    }
}
