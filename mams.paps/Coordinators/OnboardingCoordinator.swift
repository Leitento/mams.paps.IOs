

import UIKit

protocol OnboardingCoordinatorDelegate: AnyObject {
    func onboardingCoordinatorDidFinish()
}

final class OnboardingCoordinator {
    
    // MARK: - Properties
    weak var delegate: OnboardingCoordinatorDelegate?
    weak var parentCoordinator: AppCoordinatorProtocol?
    
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
    
    init(parentCoordinator: AppCoordinatorProtocol?) {
        self.parentCoordinator = parentCoordinator
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
        parentCoordinator?.switchFlow(from: self)
    }
}

