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
        let viewModel = ProfileViewModel(coordinator: self, parentCoordinator: parentCoordinator!)
        let profileViewController = ProfileViewController(viewModel: viewModel)
        rootViewController = profileViewController
        let navigationController = UINavigationController(rootViewController: profileViewController)
        navigationController.tabBarItem = UITabBarItem(title: "Profile".localized,
                                                       image: UIImage(named: "profileTabbarIcon"),
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
        let viewControler = ProfileEditScreenController()
        navigationController?.pushViewController(viewControler, animated: true)
    }
    
    func pushAddButton() {
        print("showMapScreen")
    }
    
    func pushFavouritesButton() {
        print("showEventsScreen")
//        let viewController = // controller with favourites places
//        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func pushNotificationButton() {
        print("showServicesScreen")
        //-> services
        
    }
    
    func pushContactOfferButton() {
        print("showUsefulScreen")
        //-> services
    }
    
    func pushAboutAppButton() {
        print("showUsefulScreen")
        //-> services
    }
    
    func pushSupportButton() {
        print("showUsefulScreen")
        //-> services
    }
    
    func pushLogoutButton() {
        print("showUsefulScreen")
        parentCoordinator!.showAuthorizationScreen()
//        let coordinator = AuthorizationCoordinator()
//        let viewModel = AuthorizationViewModel(coordinator: <#AuthorizationCoordinatorProtocol#>, authorizationService: <#AuthorizationServiceProtocol#>)
//        let authorizationViewController = AuthorizationViewController(viewModel: viewModel)
//        navigationController?.pushViewController(authorizationViewController, animated: true)
//        //-> authorizationServices
    }
}
