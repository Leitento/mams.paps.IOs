

import UIKit

final class RoundedBottomView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        layer.cornerRadius = 20
    }
}
