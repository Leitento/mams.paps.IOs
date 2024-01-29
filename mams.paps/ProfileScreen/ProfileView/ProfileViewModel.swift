//
//  ProfileViewModel.swift
//  mams.paps
//
//  Created by Юлия Кагирова on 18.01.2024.
//

import UIKit


protocol ProfileViewModelProtocol {
    var stateChanger: ((ProfileViewModel.State) -> Void)? { get set }
    func test()
}

final class ProfileViewModel {
    enum State {
        case loading
        case loaded(profile: Profile)
        case error
    }
    
    //MARK: - Properties
    
    var stateChanger: ((State) -> Void)?
    
    var state: State = .loading {
        didSet {
            self.stateChanger?(state)
        }
    }
    
    //MARK: - Life Cycle
    
    init() {
//       getProfile()
       
    }
    
    //MARK: - Private Methods
    
    private func getProfile() {
        let profileModel = ProfileModel(name: "Name", secondName: "SecondName", city: "City", email: "gmail.com")
        let bannerModel = BannerModel(banner: UIImage(systemName: "banner"))
        let buttonsModel = ButtonsModel.makeButtons()
        let profile =  Profile(profileModel: profileModel, bannerModel: bannerModel, buttonsModel: buttonsModel)
        state = .loaded(profile: profile)
    }
}

extension ProfileViewModel: ProfileViewModelProtocol {
    func test() {
        getProfile()
    }
}
