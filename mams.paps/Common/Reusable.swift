

import UIKit

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

extension UICollectionViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}

public extension UIView {
    
    func addSubviews(_ subviews: UIView..., translatesAutoresizingMaskIntoConstraints: Bool = false ) {
        subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints
            addSubview($0)
        }
    }
}
