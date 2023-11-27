

import UIKit

protocol OnboardingCoordinatorDelegate: AnyObject {
    func onboardingCoordinatorDidFinish()
}


final class OnboardingCoordinator {
    
    weak var delegate: OnboardingCoordinatorDelegate?
    
    let navigationController: UINavigationController
    
    var childCoordinators: [CoordinatorProtocol] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
    }
    
    func createNavigationController() {
        let onboardingViewController = OnboardingViewController()
        let onboardingNavigationController = UINavigationController(rootViewController: onboardingViewController)
//        onboardingViewController.delegate = self
        navigationController.pushViewController(onboardingNavigationController, animated: true)
    }
    
    func showNextScreen() {
        
    }
    
}

extension OnboardingCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        <#code#>
    }
    
}

extension OnboardingCoordinator: OnboardingCoordinatorDelegate {
    func onboardingCoordinatorDidFinish() {
        print("Next flow")
    }
}

//extension OnboardingCoordinator: OnboardingViewControllerDelegate {
//    func onboardingViewControllerDidDisappear() {
//        delegate?.onboardingCoordinatorDidFinish(self)
//    }
    
    
//}



