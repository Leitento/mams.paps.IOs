

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
    
    enum State {
        case guestScreen
        case userScreen(user: User)
    }
    
    //MARK: - Private Properties
    private let coordinator: MainCoordinatorDelegate
    
    //MARK: - Properties
    var currentUser: User?
    
    var mainMenu: [MainMenuItem] {
        MainMenuItem.make()
    }
                
    //MARK: - Life Cycles
    init(user: User?, coordinator: MainCoordinatorDelegate) {
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

