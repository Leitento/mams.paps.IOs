//
//  ProfileCoordinator.swift
//  mams.paps
//
//  Created by Юлия Кагирова on 19.01.2024.
//

import UIKit

protocol ProfileCoordinatorProtocol: AnyObject {
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

final class ProfileScreenCoordinator {
        
    // MARK: - Properties
    
    weak var parentCoordinator: TabBarCoordinatorProtocol?
    var childCoordinators: [CoordinatorProtocol] = []
    var rootViewController: UIViewController?
    var navigationController: UINavigationController?
    
    // MARK: - Private Properties
    
    private var user: User?
    
    // MARK: - Private methods
    
    private func createNavigationController() -> UIViewController {
        let viewModel = ProfileViewModel()
        let profileViewController = ProfileViewController(viewModel: viewModel)
        rootViewController = profileViewController
        let navigationController = UINavigationController(rootViewController: profileViewController)
        navigationController.tabBarItem = UITabBarItem(title: "Profile".localized,
                                                       image: UIImage(systemName: "profile.circle"),
                                                       tag: 4)
        self.navigationController =  navigationController
        return navigationController
    }
    
    // MARK: - Life Cycle
    
    init(user: User?, parentCoordinator: TabBarCoordinatorProtocol) {
        self.user = user
        self.parentCoordinator = parentCoordinator
    }
}

// MARK: - CoordinatorProtocol

extension ProfileScreenCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        createNavigationController()
    }
}

// MARK: - ProfileCoordinatorDelegate

extension ProfileScreenCoordinator: ProfileCoordinatorProtocol {
    
    func showProfileScreen() {
        print("showProfileScreen")
        
    }
    
    func pushProfileEditingButton() {
        print("showProfileEditingButton")
    }
    
    func pushAddButton() {
        print("showMapScreen")
    }
    
    func pushFavouritesButton() {
        print("showEventsScreen")
    }
    
    func pushNotificationButton() {
        print("showServicesScreen")
    }
    
    func pushContactOfferButton() {
        print("showUsefulScreen")
    }
    
    func pushAboutAppButton() {
        print("showUsefulScreen")
    }
    
    func pushSupportButton() {
        print("showUsefulScreen")
    }
    
    func pushLogoutButton() {
        print("showUsefulScreen")
    }
}
