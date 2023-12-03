import UIKit

class AuthTextField: UITextField {
    
    private let textPadding = UIEdgeInsets(
        top: 0,
        left: 12,
        bottom: 0,
        right: 24
    )
    
    private let iconSpacing: CGFloat = 24
    private let iconWidth: CGFloat = 20

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var iconRect = super.leftViewRect(forBounds: bounds)
        iconRect.size.width = iconWidth
        iconRect.origin.x += iconSpacing
        return iconRect
    }
    
    init(placeholder: String, fontSize: CGFloat, icon: UIImage?) {
        super.init(frame: .zero)
        commonInit(placeholder: placeholder, fontSize: fontSize, icon: icon)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit(placeholder: "", fontSize: 16, icon: nil)
    }
    
    private func commonInit(placeholder: String, fontSize: CGFloat, icon: UIImage?) {
        translatesAutoresizingMaskIntoConstraints = false
        self.placeholder = placeholder
        font = .systemFont(ofSize: fontSize, weight: .regular)
        textColor = .black
        tintColor = .black
        backgroundColor = .white
        autocapitalizationType = .none
        autocorrectionType = .no
        keyboardType = .default
        returnKeyType = .done
        clearButtonMode = .whileEditing
        contentVerticalAlignment = .center
        layer.cornerRadius = 24
        adjustsFontSizeToFitWidth = true
        delegate = self
        
        if let icon = icon {
            let iconImageView = UIImageView(image: icon)
            iconImageView.contentMode = .scaleAspectFit
            leftView = iconImageView
            leftViewMode = .always
        }
    }
}

extension AuthTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}



