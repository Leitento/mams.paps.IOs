

import UIKit

protocol Configurable: AnyObject {
    func setup(with mainMenuItem: MainMenuItem)
}

final class MainCollectionViewCell: UICollectionViewCell {
    
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

    private func setupSubviews() {
        contentView.addSubview(imageView)
        contentView.addSubview(textLabel)
    }

    private func setupLayout() {
        
        NSLayoutConstraint.activate([
            
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, constant: -10),
            
            textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    private func setupContentView() {
        contentView.layer.cornerRadius = 20
        contentView.layer.borderWidth = 3
        contentView.layer.borderColor = UIColor.systemGray.cgColor
    }
    
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

extension MainCollectionViewCell: Configurable {
    func setup(with mainMenuItem: MainMenuItem) {
        imageView.image = UIImage(named: mainMenuItem.imageName)
        textLabel.text = mainMenuItem.text
    }
}
