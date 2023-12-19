

import UIKit

protocol AppCoordinatorProtocol: AnyObject {
    func switchToNextBranch(from coordinator: CoordinatorProtocol)
}

final class AppCoordinator {
    
    // MARK: - Properties
    var childCoordinators: [CoordinatorProtocol] = []
    
    // MARK: - Private properties
    private var rootViewController: UIViewController
    
    private lazy var onboardingCoordinator: CoordinatorProtocol = {
        let onboardingCoordinator = OnboardingCoordinator(parentCoordinator: self)
        return onboardingCoordinator
    }()
    
    private lazy var authorizationCoordinator: CoordinatorProtocol = {
        let authorizationCoordinator = AuthorizationCoordinator(parentCoordinator: self)
        return authorizationCoordinator
    }()
    
    private lazy var mainScreenCoordinator: CoordinatorProtocol = {
        let mainScreenCoordinator = MainScreenCoordinator(user: nil, parentCoordinator: self)
        mainScreenCoordinator.navigationController = UINavigationController(rootViewController: mainScreenCoordinator.start())
        return mainScreenCoordinator
    }()
    
    // MARK: - Life Cycle
    init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    // MARK: - Private methods
    private func showOnboarding() -> UIViewController {
        addChildCoordinator(onboardingCoordinator)
        setFlow(to: onboardingCoordinator.start())
        return rootViewController
    }
    
    private func showMainScreen(for user: User?) -> UIViewController {
        let mainScreenCoordinator = MainScreenCoordinator(user: user, parentCoordinator: self)
        addChildCoordinator(mainScreenCoordinator)
        setFlow(to: mainScreenCoordinator.start())
        return rootViewController
    }
    
    private func setFlow(to newViewController: UIViewController) {
        rootViewController.addChild(newViewController)
        newViewController.view.frame = rootViewController.view.frame
        rootViewController.view.addSubview(newViewController.view)
        newViewController.didMove(toParent: rootViewController)
    }
    
    private func switchCoordinators(from previousCoordinator: CoordinatorProtocol, to nextCoordinator: CoordinatorProtocol) {
        addChildCoordinator(nextCoordinator)
        switchFlow(to: nextCoordinator.start())
        removeChildCoordinator(previousCoordinator)
    }
    
    private func switchFlow(to newViewController: UIViewController) {
        guard let currentViewController = rootViewController.children.first else {
            return
        }
        
        currentViewController.willMove(toParent: nil)
        currentViewController.navigationController?.isNavigationBarHidden = true
        rootViewController.addChild(newViewController)
        newViewController.view.frame = rootViewController.view.bounds
        
        rootViewController.transition(
            from: rootViewController.children[0],
            to: newViewController,
            duration: 0.5,
            options: [.transitionFlipFromRight]
        ) { [weak self] in
            guard let self else { return }
            currentViewController.removeFromParent()
            newViewController.didMove(toParent: rootViewController)
        }
    }
    
    private func isFirstLaunch() -> Bool {
        return !UserDefaults.standard.bool(forKey: "isFirstLaunch")
    }
        
    private func markAppAsLaunched() {
        UserDefaults.standard.set(true, forKey: "isFirstLaunch")
    }
    
    private func addChildCoordinator(_ coordinator: CoordinatorProtocol) {
        childCoordinators.append(coordinator)
    }
    
    private func removeChildCoordinator(_ coordinator: CoordinatorProtocol) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
}

// MARK: - CoordinatorProtocol
extension AppCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        if isFirstLaunch() {
            showOnboarding()
        } else {
            showMainScreen(for: nil)
        }
    }
}

// MARK: - AppCoordinatorProtocol
extension AppCoordinator: AppCoordinatorProtocol {
    
    func switchToNextBranch(from coordinator: CoordinatorProtocol) {
        if coordinator === onboardingCoordinator {
            switchCoordinators(from: coordinator, to: authorizationCoordinator)
        } else if coordinator === authorizationCoordinator {
            markAppAsLaunched()
            switchCoordinators(from: coordinator, to: mainScreenCoordinator)
        }
    }
}
