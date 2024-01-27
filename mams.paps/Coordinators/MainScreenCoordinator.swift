

import UIKit

protocol MainScreenCoordinatorProtocol: AnyObject {
    func switchToNextBranch(from coordinator: CoordinatorProtocol)
    func mainScreenCoordinatorDidFinish()
    func presentAvailableCities()
}

final class MainScreenCoordinator {
    
    // MARK: - Properties
    let parentCoordinator: TabBarCoordinatorProtocol
    var navigationController: UINavigationController
    
    // MARK: - Private Properties
    private var user: UserModel?
    
    // MARK: - Life Cycle
    init(navigationController: UINavigationController, parentCoordinator: TabBarCoordinatorProtocol) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
        self.user = CoreDataService.shared.fetchUserFromCoreData()
    }
    
    // MARK: - Private method
    private func createNavigationController() -> UIViewController {
        let viewModel = MainScreenViewModel(user: user, coordinator: self, parentCoordinator: parentCoordinator)
        let mainScreenViewController = MainScreenViewController(viewModel: viewModel)
        mainScreenViewController.hidesBottomBarWhenPushed = true
        let navigationController = UINavigationController(rootViewController: mainScreenViewController)
        navigationController.tabBarItem = UITabBarItem(title: "MainScreen.Title".localized, image: UIImage(systemName: "house.fill"), tag: 0)
        self.navigationController = navigationController
        return navigationController
    }
}
    
    // MARK: - CoordinatorProtocol
extension MainScreenCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        createNavigationController()
    }
}

    // MARK: - MainScreenCoordinatorProtocol
extension MainScreenCoordinator: MainScreenCoordinatorProtocol {
    func mainScreenCoordinatorDidFinish() {
        
    }
    
    func showAuthorizationScreen() {
        
    }
    
    func pushMapScreen() {
        parentCoordinator.pushMapScreen()
    }
    
    func pushEventsScreen() {
        
    }
    
    func pushServicesScreen() {
        
    }
    
    func pushUsefulScreen() {
        
    }
    
    func presentAvailableCities() {
        
    }
    
    func switchToNextBranch(from coordinator: CoordinatorProtocol) {
        
    }
}
