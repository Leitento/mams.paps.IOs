

import UIKit

protocol OnboardingCoordinatorDelegate: AnyObject {
    func onboardingCoordinatorDidFinish()
}

final class OnboardingCoordinator {
    
    // MARK: - Properties
    weak var delegate: OnboardingCoordinatorDelegate?
    
    // MARK: - Private methods
    private func createNavigationController() -> UIViewController {
        
        let slides: [Slide] = [
            Slide(image: UIImage(named: "firstPage"), text: "OnboardingFirstPage.text".localized + "!"),
            Slide(image: UIImage(named: "secondPage"), text: "OnboardingSecondPage.text".localized + "!"),
            Slide(image: UIImage(named: "thirdPage"), text: "OnboardingThirdPage.text".localized + ".")
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

    // MARK: - OnboardingCoordinatorDelegate
extension OnboardingCoordinator: OnboardingCoordinatorDelegate {
    func onboardingCoordinatorDidFinish() {
        delegate?.onboardingCoordinatorDidFinish()
    }
}

