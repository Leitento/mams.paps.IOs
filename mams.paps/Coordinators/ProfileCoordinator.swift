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
    func pushBannerButton()
    func pushFavouritesButton()
    func pushNotificationButton()
    func pushContactOfferButton()
    func pushAboutAppButton()
    func pushSupportButton()
    func pushLogoutButton()
}

final class ProfileScreenCoordinator {
    
    // MARK: - Private Properties
    
    private var user: User?
    private weak var parentCoordinator: TabBarCoordinatorProtocol?
    private var childCoordinators: [CoordinatorProtocol] = []
    private var rootViewController: UIViewController?
    private var navigationController: UINavigationController?
    
    // MARK: - Life Cycle
    
    init(user: User?, parentCoordinator: TabBarCoordinatorProtocol) {
        self.user = user
        self.parentCoordinator = parentCoordinator
    }
    
    // MARK: - Private methods
    
    private func createNavigationController() -> UIViewController {
        let viewModel = ProfileViewModel(coordinator: self)
        let profileViewController = ProfileViewController(viewModel: viewModel)
        rootViewController = profileViewController
        let navigationController = UINavigationController(rootViewController: profileViewController)
        navigationController.tabBarItem = UITabBarItem(title: "Profile".localized,
                                                       image: UIImage(systemName: "person.crop.circle"),
                                                       tag: 4)
        self.navigationController =  navigationController
        return navigationController
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
        let viewControler = ProfileEditScreenController()
        navigationController?.pushViewController(viewControler, animated: true)
    }
    
    func pushBannerButton() {
        print("showMapScreen")
    }
    
    func pushFavouritesButton() {
        print("showEventsScreen")
    }
    
    func pushNotificationButton() {
        print("showServicesScreen")
        let viewController = NotificationViewController()
        viewController.profileCoordinator = self
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func pushContactOfferButton() {
        print("showUsefulScreen")
        let viewController = ContractOfferViewController()
//        viewController.coordinator = self
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func pushAboutAppButton() {
        print("showUsefulScreen")
        let viewController = AboutAppViewController()
        viewController.profileCoordinator = self
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func pushSupportButton() {
        print("showUsefulScreen")
        let viewController = SupportViewController()
        viewController.profileCoordinator = self
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func pushLogoutButton() {
        print("showUsefulScreen")
        parentCoordinator?.showAuthorizationScreen()
        //        parentCoordinator!.showAuthorizationScreen()
    }
}

