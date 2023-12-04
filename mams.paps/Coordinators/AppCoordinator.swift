

import UIKit

class AppCoordinator {
    
    // MARK: - Properties
    var childCoordinators: [CoordinatorProtocol] = []
    var navigationController: UINavigationController?
    
    // MARK: - Private methods
    private func showOnboarding() -> UIViewController {
        let onboardingCoordinator = OnboardingCoordinator()
        onboardingCoordinator.delegate = self
        childCoordinators.append(onboardingCoordinator)
        return onboardingCoordinator.start()
    }
    
    private func showAuthorizationScreen() -> UIViewController {
        let authorizationCoordinator = AuthorizationCoordinator()
        authorizationCoordinator.delegate = self
        childCoordinators.append(authorizationCoordinator)
        return authorizationCoordinator.start()
    }
}

    // MARK: - CoordinatorProtocol
extension AppCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        showOnboarding()
    }
}

    // MARK: - OnboardingCoordinatorDelegate
extension AppCoordinator: OnboardingCoordinatorDelegate {
    func onboardingCoordinatorDidFinish() {
        childCoordinators.removeAll()
        let authorizationScreen = showAuthorizationScreen()
        navigationController?.setViewControllers([authorizationScreen], animated: true)
    }
}

    // MARK: - AuthorizationCoordinatorDelegate
extension AppCoordinator: AuthorizationCoordinatorDelegate {
    
    func authorizationCoordinatorDidFinish() {
        childCoordinators.removeAll()
        print("Show Main Screen")
    }
}

