

import UIKit

    // MARK: - OnboardingViewModelProtocol
protocol OnboardingViewModelProtocol {
    var slides: [Slide] { get }
    var currentSlide: Int { get }
    var stateDidChange: ((OnboardingViewModel.State) -> Void)? { get set }
    func getNextFlow()
}

final class OnboardingViewModel {
    
    enum State {
        case firstPage
        case secondPage
        case thirdPage
    }

    // MARK: - Properties
    let slides: [Slide]
    
    var stateDidChange: ((State) -> Void)?
    
    // MARK: - Private properties
    private var currentState: State = .firstPage {
        didSet {
            stateDidChange?(currentState)
        }
    }
    
    private var coordinator: OnboardingCoordinatorProtocol

    // MARK: - Life Cycle
    init(slides: [Slide], coordinator: OnboardingCoordinatorProtocol, stateDidChange: ((State) -> Void)? = nil) {
        self.slides = slides
        self.coordinator = coordinator
    }
}

    // MARK: - OnboardingViewModelProtocol
extension OnboardingViewModel: OnboardingViewModelProtocol {
        
    var currentSlide: Int {
            switch currentState {
            case .firstPage:
                return 0
            case .secondPage:
                return 1
            case .thirdPage:
                return 2
            }
    }
    
    func getNextFlow() {
        coordinator.onboardingCoordinatorDidFinish()
    }
}
