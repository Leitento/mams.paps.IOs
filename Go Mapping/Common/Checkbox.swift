

import UIKit

final class Checkbox: UIView {
    var isChecked = false
    private let checkbox = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }
    
    private func setupSubviews() {
        checkbox.contentMode = .scaleAspectFit
        checkbox.tintColor = UIColor(named: "customSkin")
        
        addSubview(checkbox)
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            checkbox.topAnchor.constraint(equalTo: topAnchor),
            checkbox.leadingAnchor.constraint(equalTo: leadingAnchor),
            checkbox.trailingAnchor.constraint(equalTo: trailingAnchor),
            checkbox.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        toggle()
    }
        
    func toggle() {
        
        if isChecked {
            checkbox.image = UIImage(systemName: "checkmark.square.fill")
            checkbox.tintColor = UIColor(named: "customRed")
        } else {
            checkbox.image = UIImage(systemName: "square.fill")
            checkbox.tintColor = UIColor(named: "customSkin")
        }
        
        isChecked = !isChecked
    }
}
