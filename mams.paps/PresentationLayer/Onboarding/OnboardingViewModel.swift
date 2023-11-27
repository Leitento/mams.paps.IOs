


import UIKit

enum State {
    case firstPage
    case secondPage
    case thirdPage
}

struct OnboardingViewModel {
    var state: State {
        didSet {
            StateDidChange?(state)
        }
    }
    
    var StateDidChange: ((State) -> Void)?
    
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
}
