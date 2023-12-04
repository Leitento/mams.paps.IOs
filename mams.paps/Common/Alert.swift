

import UIKit

public struct Alert {
    
    func showAlert(on viewController: UIViewController, title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion?()
        }))
        viewController.present(alert, animated: true, completion: nil)
    }
}
