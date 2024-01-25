

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView..., translatesAutoresizingMaskIntoConstraints: Bool = true) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
            self.addSubview($0)
        }
    }
}
