

import UIKit


protocol AppCoordinatorProtocol: AnyObject {
    func switchFlow(from coordinator: CoordinatorProtocol)
}

final class AppCoordinator {
    
    // MARK: - Properties
    var isFirstLaunch: Bool = true
    var childCoordinators: [CoordinatorProtocol] = []
    private var rootViewController: UIViewController
    
    // MARK: - Private methods
    private func showOnboarding() -> UIViewController {
        let onboardingCoordinator = OnboardingCoordinator(parentCoordinator: self)
        childCoordinators.append(onboardingCoordinator)
        return onboardingCoordinator.start()
    }
    
    private func showAuthorizationScreen() -> UIViewController {
        let authorizationCoordinator = AuthorizationCoordinator()
        authorizationCoordinator.delegate = self
        childCoordinators.append(authorizationCoordinator)
        return authorizationCoordinator.start()
    }
    
    private func showMainScreen(for user: User?) -> UIViewController {
        let mainCoordinator = MainCoordinator(user: user)
        childCoordinators.append(mainCoordinator)
        return mainCoordinator.start()
    }
    
    private func whichPushCoordinator() -> UIViewController {
        if isFirstLaunch {
            return showOnboarding()
        } else {
            let user = User(login: <#T##String#>, password: <#T##String#>, city: <#T##String?#>, userName: <#T##String?#>)
            return showMainScreen(for: user)
        }
    }

    
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
}

    // MARK: - CoordinatorProtocol
extension AppCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        whichPushCoordinator()
    }
}

extension AppCoordinator: AppCoordinatorProtocol {
    func switchFlow(from coordinator: CoordinatorProtocol) {
        
    }
}

    // MARK: - OnboardingCoordinatorDelegate
//extension AppCoordinator: OnboardingCoordinatorDelegate {
//    func onboardingCoordinatorDidFinish() {
//        childCoordinators.removeAll()
//        let authorizationScreen = showAuthorizationScreen()
//        navigationController?.setViewControllers([authorizationScreen], animated: true)
//    }
//}

    // MARK: - AuthorizationCoordinatorDelegate
extension AppCoordinator: AuthorizationCoordinatorDelegate {
    func authorizationCoordinatorDidFinish(user: User?) {
        childCoordinators.removeAll()
        let mainScreen = showMainScreen(for: user)
        navigationController?.setViewControllers([mainScreen], animated: true)
    }
}
