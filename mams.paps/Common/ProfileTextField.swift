//
//  ProfileTextField.swift
//  mams.paps
//
//  Created by Юлия Кагирова on 15.04.2024.
//

import UIKit

final class ProfileTextField: UITextField {
     init(placeholder: String) {
         super.init(frame: .zero)
         self.layer.borderColor = UIColor.customDarkBlue.cgColor
         self.layer.borderWidth = 2
         self.keyboardType = .emailAddress
         self.font = Fonts.regular16
         self.autocapitalizationType = .none
         self.clearButtonMode = UITextField.ViewMode.whileEditing
         self.returnKeyType = .done
         self.layer.cornerRadius = LayoutConstants.cornerRadius
         self.textAlignment = .left
         self.leftViewMode = .always
         self.textColor = .customGreyButtons
         self.backgroundColor = .white
         let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
         self.leftView = paddingView
         self.attributedPlaceholder = NSAttributedString.init(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.customGreyButtons]
         )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class ProfileLabel: UILabel {
    init(label: String) {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.text = " " + label + " "
        self.font = Fonts.regular12
        self.textColor = .customDarkBlue
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = .scaleAspectFit
        self.clipsToBounds = true
        self.sizeToFit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
