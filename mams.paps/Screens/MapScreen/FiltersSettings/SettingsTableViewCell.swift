

import UIKit

final class SettingsTableViewCell: UITableViewCell {
    
    private enum Constants {
        static let verticalPadding: CGFloat = 5.0
        static let horizontalPadding: CGFloat = 10.0
        static let checkboxSize: CGFloat = 24.0
    }
    
    private lazy var checkbox: Checkbox = {
        let checkbox = Checkbox()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapCheckbox))
        checkbox.addGestureRecognizer(gesture)
        return checkbox
    }()
    
    private lazy var checkboxTitle: UILabel = {
        let checkboxTitle = UILabel()
        checkboxTitle.translatesAutoresizingMaskIntoConstraints = false
        checkboxTitle.font = .systemFont(ofSize: 14, weight: .regular)
        checkboxTitle.textColor = .black
        checkboxTitle.textAlignment = .left
        checkboxTitle.numberOfLines = 0
        checkboxTitle.adjustsFontSizeToFitWidth = true
        return checkboxTitle
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        contentView.addSubviews(checkbox,
                                checkboxTitle,
                                translatesAutoresizingMaskIntoConstraints: false)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            checkbox.topAnchor.constraint(equalTo: contentView.topAnchor,
                                            constant: Constants.verticalPadding),
            checkbox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                constant: Constants.horizontalPadding),
            checkbox.widthAnchor.constraint(equalToConstant: Constants.checkboxSize),
            checkbox.heightAnchor.constraint(equalToConstant: Constants.checkboxSize),
            checkbox.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            checkboxTitle.topAnchor.constraint(equalTo: contentView.topAnchor,
                                            constant: Constants.verticalPadding),
            checkboxTitle.leadingAnchor.constraint(equalTo: checkbox.trailingAnchor,
                                                constant: Constants.horizontalPadding),
            checkboxTitle.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor),
            checkboxTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                            constant: -Constants.verticalPadding),
            checkboxTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    @objc private func didTapCheckbox() {
        checkbox.toggle()
        if checkbox.isChecked == true {
            print("Unchecked")
        } else {
            print("Checked")
        }
    }
}
        
extension SettingsTableViewCell: Configurable {
    func setup(with item: SettingsOption) {
        checkboxTitle.text = item.name
    }
}
