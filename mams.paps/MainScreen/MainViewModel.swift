

import Foundation

protocol MainViewModelProtocol: AnyObject {
    var mainMenu: [MainMenuItem] { get }
    var currentUser: User? { get }
    func locationDidTap()
    func userNameDidTap()
    func showMapScreen()
    func showEventsScreen()
    func showServicesScreen()
    func showUsefulScreen()
}

final class MainViewModel {
    
    //MARK: - Private Properties
    private let coordinator: MainScreenCoordinatorDelegate
    
    //MARK: - Properties
    var currentUser: User?
    
    var mainMenu: [MainMenuItem] {
        MainMenuItem.make()
    }
                
    //MARK: - Life Cycles
    init(user: User?, coordinator: MainScreenCoordinatorDelegate) {
        self.currentUser = user
        self.coordinator = coordinator
    }
}

    //MARK: - AuthorizationViewModelProtocol
extension MainViewModel: MainViewModelProtocol {
    
    func locationDidTap() {
        coordinator.presentAvailableCities()
    }
    
    func userNameDidTap() {
        coordinator.showAuthorizationScreen()
    }
    
    func showMapScreen() {
        coordinator.pushMapScreen()
    }
    
    func showEventsScreen() {
        coordinator.pushEventsScreen()
    }
    
    func showServicesScreen() {
        coordinator.pushServicesScreen()
    }
    
    func showUsefulScreen() {
        coordinator.pushUsefulScreen()
    }
    
}

