

import UIKit

protocol MainScreenViewProtocol: AnyObject {
    func firstCellDidTap()
    func secondCellDidTap()
    func thirdCellDidTap()
    func fourthCellDidTap()
    func locationLabelTapped()
    func userNameLabelTapped()
}

final class MainScreenView: UIView {
    
    private enum Constants {
        static let aspectRatioMultiplier: CGFloat = 325 / 390
        static let padding: CGFloat = 20
        static let itemHeight: CGFloat = 24
    }
    
    weak var delegate: MainScreenViewProtocol?
    
    // MARK: - Private properties
    private let mainMenu: [MainScreenMenuItem]
    private var currentUser: UserModel?
    
    private lazy var topView: UIView = {
        let topView = RoundedBottomView()
        topView.backgroundColor = .white
        return topView
    }()
    
    private lazy var locationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.addArrangedSubview(locationIcon)
        stackView.addArrangedSubview(locationLabel)
        stackView.addArrangedSubview(locationArrowIcon)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapOnLocationLabel))
        stackView.isUserInteractionEnabled = true
        stackView.addGestureRecognizer(gesture)
        
        return stackView
    }()
    
    private lazy var usernameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.addArrangedSubview(userNameIcon)
        stackView.addArrangedSubview(userNameLabel)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapOnUserNameLabel))
        stackView.isUserInteractionEnabled = true
        stackView.addGestureRecognizer(gesture)
        
        return stackView
    }()
    
    private lazy var locationIcon: UIImageView = {
        let locationIcon = UIImageView()
        locationIcon.translatesAutoresizingMaskIntoConstraints = false
        locationIcon.image = UIImage(named: "locationIcon")
        return locationIcon
    }()
    
    private lazy var locationLabel: UILabel = {
        let locationLabel = UILabel()
        locationLabel.font = .systemFont(ofSize: 16, weight: .regular)
        locationLabel.textColor = .black
        locationLabel.textAlignment = .left
        locationLabel.text = currentUser?.city ?? "Текущий город"
        return locationLabel
    }()
    
    private lazy var locationArrowIcon: UIImageView = {
        let locationArrowIcon = UIImageView()
        locationArrowIcon.translatesAutoresizingMaskIntoConstraints = false
        locationArrowIcon.image = UIImage(named: "locationArrowIcon")
        return locationArrowIcon
    }()
    
    private lazy var userNameLabel: UILabel = {
        let userNameLabel = UILabel()
        userNameLabel.font = .systemFont(ofSize: 16, weight: .regular)
        userNameLabel.textColor = .black
        userNameLabel.textAlignment = .left
        userNameLabel.numberOfLines = 2
        userNameLabel.text = currentUser?.name ?? "Гость"
        return userNameLabel
    }()
    
    private lazy var userNameIcon: UIImageView = {
        let userNameIcon = UIImageView()
        userNameIcon.translatesAutoresizingMaskIntoConstraints = false
        userNameIcon.image = UIImage(systemName: "circle.fill")
        userNameIcon.tintColor = UIColor(named: "customSkin")
        userNameIcon.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .regular)
        if let firstLetter = currentUser?.name?.first {
            label.text = String(firstLetter)
        } else {
            label.text = "Г"
        }
        label.textAlignment = .center
        label.textColor = .white
        
        userNameIcon.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: userNameIcon.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: userNameIcon.centerYAnchor)
        ])
        return userNameIcon
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "mainScreenLogo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.register(MainScreenCollectionViewCell.self, forCellWithReuseIdentifier: MainScreenCollectionViewCell.identifier)
        return collectionView
    }()
    
    // MARK: - Life Cycle
    init(user: UserModel?, mainMenu: [MainScreenMenuItem]) {
        self.currentUser = user
        self.mainMenu = mainMenu
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
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func addSubviews() {
        addSubviews(
            topView,
            collectionView,
            translatesAutoresizingMaskIntoConstraints: false
        )
        topView.addSubviews(
            locationStackView,
            usernameStackView,
            imageView,
            translatesAutoresizingMaskIntoConstraints: false
        )
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: topAnchor),
            topView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            topView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.aspectRatioMultiplier, constant: Constants.padding),
            
            usernameStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.padding),
            usernameStackView.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: Constants.padding),
            usernameStackView.heightAnchor.constraint(equalToConstant: Constants.itemHeight),
            
            locationStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.padding),
            locationStackView.leadingAnchor.constraint(equalTo: usernameStackView.trailingAnchor, constant: -Constants.padding),
            locationStackView.trailingAnchor.constraint(greaterThanOrEqualTo: topView.trailingAnchor, constant: -Constants.padding),
            locationStackView.heightAnchor.constraint(equalToConstant: Constants.itemHeight),
            
            locationIcon.widthAnchor.constraint(equalToConstant: Constants.padding),
            locationArrowIcon.widthAnchor.constraint(equalToConstant: 9),
            locationArrowIcon.heightAnchor.constraint(equalTo: locationStackView.heightAnchor, multiplier: 0.5),
            userNameIcon.widthAnchor.constraint(equalToConstant: Constants.itemHeight),
            userNameIcon.heightAnchor.constraint(equalToConstant: Constants.itemHeight),
            
            imageView.topAnchor.constraint(equalTo: locationStackView.bottomAnchor, constant: Constants.padding),
            imageView.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            imageView.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -34),
            
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

// MARK: - UICollectionViewDataSource
extension MainScreenView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        mainMenu.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainScreenCollectionViewCell.identifier, for: indexPath) as? MainScreenCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setup(with: mainMenu[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainScreenView: UICollectionViewDelegateFlowLayout {
    
    private func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        
        let itemsInRow: CGFloat = 2
        let totalSpacing: CGFloat = 2 * spacing + (itemsInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / itemsInRow
        return floor(finalWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = itemWidth(for: frame.width, spacing: Constants.padding)
        return CGSize(width: width, height: (collectionView.frame.height - 3 * Constants.padding) / 2)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: Constants.padding, left: Constants.padding, bottom: Constants.padding, right: Constants.padding)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.padding
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.padding
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.cellForItem(at: indexPath) is MainScreenCollectionViewCell {
            if indexPath.item == 0 {
                delegate?.firstCellDidTap()
            }
            
            if indexPath.item == 1 {
                delegate?.secondCellDidTap()
            }
            
            if indexPath.item == 2 {
                delegate?.thirdCellDidTap()
            }
            
            if indexPath.item == 3 {
                delegate?.fourthCellDidTap()
            }
        }
    }
}
