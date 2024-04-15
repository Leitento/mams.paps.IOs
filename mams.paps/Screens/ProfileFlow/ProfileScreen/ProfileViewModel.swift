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
    
    private var profile: Profile?
    private weak var coordinator: ProfileCoordinatorProtocol?
    var stateChanger: ((State) -> Void)?
    var state: State = .loading {
        didSet {
            self.stateChanger?(state)
        }
    }
    private let profileApiService: ProfileAPIServiceProtocol
    //MARK: - Life Cycle
    
    init(coordinator: ProfileCoordinatorProtocol, profileApiService: ProfileAPIServiceProtocol) {
        self.coordinator = coordinator
        self.profileApiService = profileApiService
    }
    
    //MARK: - Private Methods
    
    private func getProfile() {
        Task { @MainActor [weak self] in
            guard let self else { return } 
            do {
                let userModel = try await profileApiService.getProfile()
                let bannerModel = BannerModel(banner: UIImage(systemName: "banner"))
                let buttonsModel = ButtonsModel.makeButtons()
                let profile =  Profile(profileUser: userModel, bannerModel: bannerModel, buttonsModel: buttonsModel)
                self.profile = profile
                state = .loaded(profile: profile)
            } catch {
                state = .error
            }
            
           
        }
//        let profileModel = ProfileUser(id: 123 ,name: "name", secondName: "secName", city: "city",
//        email: "mail@gmail.com", telephone: "8(900) 99-99-999", dateOfBirth: "12.12.12", avatar: "url")
//        let bannerModel = BannerModel(banner: UIImage(systemName: "banner"))
//        let buttonsModel = ButtonsModel.makeButtons()
//        let profile =  Profile(profileModel: profileModel, bannerModel: bannerModel, buttonsModel: buttonsModel)
//        state = .loaded(profile: profile)
    }
}

extension ProfileViewModel: ProfileViewModelProtocol {
    func didTappedGetProfile() {
        getProfile()
    }
    func didTappedEditProfile() {
        guard let profile else { return }
        coordinator?.pushProfileEditingButton(profile: profile)
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
