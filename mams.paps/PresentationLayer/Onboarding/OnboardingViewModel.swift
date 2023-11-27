


import UIKit

protocol OnboardingViewModelProtocol {
    var stateDidChange: ((OnboardingViewModel.State) -> Void)? { get }
    func getNextFlow()
}

struct Slide {
    let image: UIImage
    let text: String
}

final class OnboardingViewModel {
    
    enum State {
        case firstPage(slide: Slide)
        case secondPage(slide: Slide)
        case thirdPage(slide: Slide)
    }
    
    var state: State {
        didSet {
            stateDidChange?(state)
        }
    }
    
    let slides: [Slide] = []
    
    private var coordinator: OnboardingCoordinatorDelegate
    
    var stateDidChange: ((State) -> Void)?
    
    var image: UIImage? {
        switch state {
        case .firstPage:
            return UIImage(named: "FirstPage")
        case .secondPage:
            return UIImage(named: "SecondPage")
        case .thirdPage:
            return UIImage(named: "ThirdPage")
        }
    }

    var text: String {
        switch state {
        case .firstPage:
            return "От родителей".localized + "\n" + "родителям".localized + "!"
        case .secondPage:
            return "Детям будет".localized + "\n" + "интересно".localized + "!"
        case .thirdPage:
            return "Локации, которые подходят именно вашей семье".localized
        }
    }
    
    init(state: State, coordinator: OnboardingCoordinatorDelegate, stateDidChange: ( (State) -> Void)? = nil) {
        self.state = state
        self.coordinator = coordinator
        self.stateDidChange = stateDidChange
    }
    
}

extension OnboardingViewModel: OnboardingViewModelProtocol {
    
    func getNextFlow() {
        coordinator.onboardingCoordinatorDidFinish()
    }

}
