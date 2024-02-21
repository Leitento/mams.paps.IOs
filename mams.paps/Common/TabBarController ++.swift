

import UIKit

extension UITabBarController {
    func animateTabBarTransition(to index: Int) {
        guard let selectedView = selectedViewController?.view, let newView = viewControllers?[index].view else {
            return
        }

        UIView.transition(from: selectedView, to: newView, duration: 0.5, options: .transitionCrossDissolve) { _ in
            // Optionally, you can perform additional actions after the transition completes.
        }

        selectedIndex = index
    }
}
