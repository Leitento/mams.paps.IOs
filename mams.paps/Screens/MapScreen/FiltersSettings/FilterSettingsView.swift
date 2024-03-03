

import UIKit

final class FilterSettingsView: UIView {
    
    private enum Constants {
        static let aspectRatioMultiplier: CGFloat = 153 / 390
        static let padding: CGFloat = 20
        static let itemHeight: CGFloat = 24
    }
    
    weak var delegate: MainScreenViewProtocol?
    
    // MARK: - Private properties
    private lazy var topView: UIView = {
        let topView = RoundedBottomView()
        topView.backgroundColor = .white
        return topView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView,
                                                     labelText])
        stackView.spacing = Constants.padding
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var labelText: UILabel = {
        let labelText = UILabel()
        labelText.translatesAutoresizingMaskIntoConstraints = false
        labelText.font = .systemFont(ofSize: 28, weight: .regular)
        labelText.textAlignment = .left
        labelText.numberOfLines = 0
        labelText.textColor = UIColor(named: "customDarkBlue")
        return labelText
    }()
    
    private lazy var collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.register(MainScreenCollectionViewCell.self, forCellWithReuseIdentifier: MainScreenCollectionViewCell.identifier)
        return collectionView
    }()
    
    // MARK: - Life Cycle
    init() {
        super.init(frame: .zero)
        setupView()
        setupCollectionView()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setupView() {
        backgroundColor = UIColor(named: "customOrange")
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .clear
        
    }
    
    private func addSubviews() {
        addSubviews(
            topView,
            collectionView,
            translatesAutoresizingMaskIntoConstraints: false
        )
        topView.addSubviews(
            stackView,
            translatesAutoresizingMaskIntoConstraints: false
        )
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            topView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            topView.heightAnchor.constraint(equalTo: widthAnchor,
                                            multiplier: Constants.aspectRatioMultiplier,
                                            constant: Constants.padding),
            
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, 
                                           constant: 5),
            stackView.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, 
                                               constant: 47),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, 
                                                constant: -47),
            stackView.bottomAnchor.constraint(equalTo: topView.bottomAnchor, 
                                              constant: -5),
            
            imageView.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.5, constant: -Constants.padding),
            labelText.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.5),
            
            collectionView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc private func tapOnLocationLabel() {
        delegate?.locationLabelTapped()
    }
    
    @objc private func tapOnUserNameLabel() {
        delegate?.userNameLabelTapped()
    }
}

