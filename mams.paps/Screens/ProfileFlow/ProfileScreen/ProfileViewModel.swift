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
    
    func didTappedButton(target: ButtonsTarget)
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
   
    func didTappedButton(target: ButtonsTarget) {
        switch target {
        case .favourites:
            coordinator?.pushFavouritesButton()
        case .myAdvertising:
            coordinator?.pushMyAddsButton()
        case .notifications:
            coordinator?.pushNotificationButton()
        case .contractOffer:
            coordinator?.pushContactOfferButton()
        case .aboutApp:
            coordinator?.pushAboutAppButton()
        case .support:
            coordinator?.pushSupportButton()
        case .logout:
            coordinator?.pushLogoutButton()
        }
    }
}
