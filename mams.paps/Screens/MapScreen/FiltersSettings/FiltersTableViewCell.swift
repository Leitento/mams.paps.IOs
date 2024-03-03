

import UIKit

final class FiltersTableViewCell: UITableViewCell {
    
    private enum Constants {
        static let verticalPadding: CGFloat = 5.0
        static let horizontalPadding: CGFloat = 10.0
        static let iconSize: CGFloat = 28.0
    }
    
    // MARK: - Private properties
    private lazy var filterIcon: UIImageView = {
        let filterIcon = UIImageView()
        filterIcon.contentMode = .scaleAspectFit
        filterIcon.tintColor = UIColor(named: "customRed")
        return filterIcon
    }()
    
    private lazy var filterLabel: UILabel = {
        let filterLabel = UILabel()
        filterLabel.translatesAutoresizingMaskIntoConstraints = false
        filterLabel.font = .systemFont(ofSize: 14, weight: .regular)
        filterLabel.textColor = .black
        filterLabel.textAlignment = .left
        filterLabel.numberOfLines = 0
        filterLabel.adjustsFontSizeToFitWidth = true
        return filterLabel
    }()
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func addSubviews() {
        contentView.addSubviews(filterIcon,
                                filterLabel,
                                translatesAutoresizingMaskIntoConstraints: false)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            filterIcon.topAnchor.constraint(equalTo: contentView.topAnchor, 
                                            constant: Constants.verticalPadding),
            filterIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                constant: Constants.horizontalPadding),
            filterIcon.widthAnchor.constraint(equalToConstant: Constants.iconSize),
            filterIcon.heightAnchor.constraint(equalToConstant: Constants.iconSize),
            filterIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            filterLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
                                            constant: Constants.verticalPadding),
            filterLabel.leadingAnchor.constraint(equalTo: filterIcon.trailingAnchor,
                                                constant: Constants.horizontalPadding),
            filterLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor),
            filterLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                            constant: -Constants.verticalPadding),
            filterLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    // MARK: - Methods
    func updateSelectedItems() {
        if isSelected {
            contentView.backgroundColor = UIColor(named: "customRed")
            filterLabel.textColor = .white
            filterIcon.image = filterIcon.image?.withTintColor(.white)
        } else {
            contentView.backgroundColor = .clear
            filterLabel.textColor = .black
            if let customRed = UIColor(named: "customRed") {
                filterIcon.image = filterIcon.image?.withTintColor(customRed)
            }
        }
    }
}
        
// MARK: - Configurable
extension FiltersTableViewCell: Configurable {
    func setup(with item: FilterOption) {
        filterIcon.image = UIImage(named: item.iconName)
        filterLabel.text = item.name
    }
}

