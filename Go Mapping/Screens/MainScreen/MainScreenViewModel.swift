

import Foundation

protocol MainScreenViewModelProtocol: AnyObject {
    var mainMenu: [MainScreenMenuItem] { get }
    var currentUser: UserModel? { get }
    func locationDidTap()
    func userNameDidTap()
    func showMapScreen()
    func showEventsScreen()
    func showServicesScreen()
    func showUsefulScreen()
}

final class MainScreenViewModel {
    
    //MARK: - Private Properties
    private let coordinator: MainScreenCoordinatorProtocol
    private let parentCoordinator: TabBarCoordinatorProtocol
    
    //MARK: - Properties
    var currentUser: UserModel?
    
    var mainMenu: [MainScreenMenuItem] {
        MainScreenMenuItem.make()
    }
                
    //MARK: - Life Cycles
    init(user: UserModel?, coordinator: MainScreenCoordinatorProtocol, parentCoordinator: TabBarCoordinatorProtocol) {
        self.currentUser = user
        self.coordinator = coordinator
        self.parentCoordinator = parentCoordinator
    }
}

    //MARK: - AuthorizationViewModelProtocol
extension MainScreenViewModel: MainScreenViewModelProtocol {
    func showMapScreen() {
        parentCoordinator.pushMapScreen()
    }
    
    func showEventsScreen() {
    }
    
    func showServicesScreen() {
    }

    func showUsefulScreen() {
    }
    
    func locationDidTap() {
        coordinator.presentAvailableCities()
    }
    
    func userNameDidTap() {
        parentCoordinator.showAuthorizationScreen()
    }
}

