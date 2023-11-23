

import Foundation

enum OnboardingState {
    case firstPage
    case secondPage
    case thirdPage
}

struct OnboardingViewModel {
    let state: OnboardingState
}
