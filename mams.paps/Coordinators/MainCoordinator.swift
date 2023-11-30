

import UIKit

class MainCoordinator {
    
    // MARK: - Properties
    var childCoordinators: [CoordinatorProtocol] = []
    
    // MARK: - Private methods
    private func showOnboarding() -> UIViewController {
        let onboardingCoordinator = OnboardingCoordinator()
        onboardingCoordinator.delegate = self
        childCoordinators.append(onboardingCoordinator)
        return onboardingCoordinator.start()
    }
}

    // MARK: - CoordinatorProtocol
extension MainCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        showOnboarding()
    }
}

    // MARK: - OnboardingCoordinatorDelegate
extension MainCoordinator: OnboardingCoordinatorDelegate {
    func onboardingCoordinatorDidFinish() {
        childCoordinators.removeAll()
        print("Show Authorization Screen")
    }
}

