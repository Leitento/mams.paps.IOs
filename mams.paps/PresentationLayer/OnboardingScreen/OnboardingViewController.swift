

import UIKit

protocol OnboardingViewControllerDelegate: AnyObject {
    func onboardingViewControllerDidDisappear()
}

final class OnboardingViewController: UIViewController {
    
    weak var delegate: OnboardingViewControllerDelegate?
    
    var coordinator: OnboardingCoordinator?
    var pageController: OnboardingPageViewController?
    
    var firstPageModel = OnboardingViewModel(state: .firstPage)
    var secondPageModel = OnboardingViewModel(state: .secondPage)
    var thirdPageModel = OnboardingViewModel(state: .thirdPage)
    
    private lazy var onboardingView: OnboardingView = {
        let onboardingView = OnboardingView(viewModel: firstPageModel)
        onboardingView.updateView(with: firstPageModel)
        onboardingView.delegate = self
        return onboardingView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createPageViewController()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        delegate?.onboardingViewControllerDidDisappear()
    }
    
    private func createPageViewController() {
        let pageViewController = OnboardingPageViewController(pagesViewModel: [firstPageModel, secondPageModel, thirdPageModel])
        addChild(pageViewController)
        didMove(toParent: self)
        view.addSubview(pageViewController.view)
    }
    
    private func updateOnboardingView(with model: OnboardingViewModel) {
        onboardingView.viewModel = model
        onboardingView.updateView(with: model)
    }
}


extension OnboardingViewController: OnboardingViewDelegate {

    func nextButtonTapped() {
        
        guard let pageController else { return }
        
        pageController.goToNextPage(animated: true, completion: nil) {
            print("переход на экран авторизации")
        }
    }
}
