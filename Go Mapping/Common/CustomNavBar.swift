import UIKit

extension UINavigationBar {
    enum Style {
        case custom(color: UIColor, titleColor: UIColor)
    }

    func applyStyle(_ style: Style) {
        switch style {
        case .custom(let color, let titleColor):
            self.barTintColor = color
//            self.isTranslucent = false
            self.titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor]
        }
    }
}

extension UIViewController {
    func setupTitleInNavigationBar(title: String, textColor: UIColor, backgroundColor: UIColor, isLeftItem: Bool) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = textColor
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        titleLabel.sizeToFit()
        
        let titleBarButtonItem = UIBarButtonItem(customView: titleLabel)
        
        if isLeftItem {
            navigationItem.leftBarButtonItem = titleBarButtonItem
            
        } else {
            navigationItem.rightBarButtonItem = titleBarButtonItem
        }
        
        navigationController?.navigationBar.applyStyle(.custom(color: backgroundColor, titleColor: textColor))
    }
    
    func setCustomBackBarItem(title: String) {
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(
            title: title,
            style: .done,
            target: self,
            action: nil)
        navigationController?.navigationBar.scrollEdgeAppearance = .none
        navigationController?.navigationBar.tintColor = .customGreyButtons
    }
}
