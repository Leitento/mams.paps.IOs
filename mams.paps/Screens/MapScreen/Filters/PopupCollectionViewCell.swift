

import UIKit

final class PopupCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Private properties
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = .systemFont(ofSize: 16, weight: .regular)
        textLabel.textColor = .black
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 2
        return textLabel
    }()

    // MARK: - Private methods
    private func setupSubviews() {
        contentView.addSubview(imageView)
        contentView.addSubview(textLabel)
    }

    private func setupLayout() {
        
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 35),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -35),
            
            textLabel.topAnchor.constraint(greaterThanOrEqualTo: imageView.bottomAnchor, constant: 7),
            textLabel.heightAnchor.constraint(equalToConstant: 40),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    private func setupContentView() {
        contentView.layer.cornerRadius = 20
        contentView.layer.borderWidth = 3
        contentView.layer.borderColor = UIColor.systemGray.cgColor
    }
    
    // MARK: - Life Cycle
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = .white
        setupSubviews()
        setupLayout()
        setupContentView()
    }
}

// MARK: - Configurable
extension PopupCollectionViewCell: Configurable {
    func setup(with items: PopupMenuItem) {
        imageView.image = UIImage(named: items.imageName)
        textLabel.text = items.text
    }
}
