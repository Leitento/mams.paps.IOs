

import UIKit

final class Alert {
    
    static let shared = Alert()
    
    init() {}
    
    func showAlert(on viewController: UIViewController, title: String, message: String?, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion?()
        }))
        viewController.present(alert, animated: true, completion: nil)
    }
}
