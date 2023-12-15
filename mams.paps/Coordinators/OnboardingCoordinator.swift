

import UIKit

protocol OnboardingCoordinatorProtocol: AnyObject {
    func onboardingCoordinatorDidFinish()
}

final class OnboardingCoordinator {
    
    // MARK: - Properties
    weak var parentCoordinator: AppCoordinatorProtocol?
    
    init(parentCoordinator: AppCoordinatorProtocol?) {
        self.parentCoordinator = parentCoordinator
    }
    
    // MARK: - Private methods
    private func createNavigationController() -> UIViewController {
        
        let slides: [Slide] = [
            Slide(image: UIImage(named: "firstPage"), text: "OnboardingFirstPage.Text".localized + "!"),
            Slide(image: UIImage(named: "secondPage"), text: "OnboardingSecondPage.Text".localized + "!"),
            Slide(image: UIImage(named: "thirdPage"), text: "OnboardingThirdPage.Text".localized + ".")
        ]
        
        let viewModel = OnboardingViewModel(slides: slides, coordinator: self)
        
        let onboardingViewController = OnboardingViewController(viewModel: viewModel)
        return onboardingViewController
    }
}

    // MARK: - CoordinatorProtocol
extension OnboardingCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        createNavigationController()
    }
}

    // MARK: - OnboardingCoordinatorProtocol
extension OnboardingCoordinator: OnboardingCoordinatorProtocol {
    func onboardingCoordinatorDidFinish() {
        parentCoordinator?.switchToNextBranch(from: self)
    }
}

