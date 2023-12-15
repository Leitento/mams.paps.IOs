

import UIKit

protocol MainViewDelegate: AnyObject {
    func firstCellDidTap()
    func secondCellDidTap()
    func thirdCellDidTap()
    func fourthCellDidTap()
    func locationLabelTapped()
    func userNameLabelTapped()
}

final class MainView: UIView {
    
    private enum Constants {
        static let aspectRatioMultiplier: CGFloat = 325 / 390
        static let padding: CGFloat = 20
        static let spacing: CGFloat = 20
    }
    
    weak var delegate: MainViewDelegate?
   
    private let mainMenu: [MainMenuItem]
    private var currentUser: User?
    
    private lazy var topView: UIView = {
        let topView = RoundedBottomView()
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.backgroundColor = .white
        return topView
    }()
    
    private lazy var locationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.addArrangedSubview(locationIcon)
        stackView.addArrangedSubview(locationLabel)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapOnLocationLabel))
        stackView.isUserInteractionEnabled = true
        stackView.addGestureRecognizer(gesture)
        
        return stackView
    }()
    
    private lazy var usernameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.addArrangedSubview(userNameLabel)
        stackView.addArrangedSubview(userNameIcon)
        
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
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.font = .systemFont(ofSize: 16, weight: .regular)
        locationLabel.textColor = .black
        locationLabel.textAlignment = .left
        locationLabel.text = currentUser?.city ?? "Текущий город"
        return locationLabel
    }()
    
    private lazy var userNameLabel: UILabel = {
        let userNameLabel = UILabel()
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.font = .systemFont(ofSize: 16, weight: .regular)
        userNameLabel.textColor = .black
        userNameLabel.textAlignment = .left
        userNameLabel.numberOfLines = 2
        userNameLabel.text = currentUser?.userName ?? "Гость"
        return userNameLabel
    }()
    
    private lazy var userNameIcon: UIImageView = {
        let userNameIcon = UIImageView()
        userNameIcon.translatesAutoresizingMaskIntoConstraints = false
        userNameIcon.image = UIImage(systemName: "circle.fill")
        userNameIcon.tintColor = .systemGray
        userNameIcon.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
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
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        return collectionView
    }()
    
    init(user: User?, mainMenu: [MainMenuItem]) {
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
    
    private func setupView() {
        backgroundColor = .systemOrange
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func addSubviews() {
        addSubview(topView)
        addSubview(collectionView)
        topView.addSubview(locationStackView)
        topView.addSubview(usernameStackView)
        topView.addSubview(imageView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: topAnchor),
            topView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            topView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.aspectRatioMultiplier, constant: 20),
            
            locationStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            locationStackView.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 20),
            locationStackView.heightAnchor.constraint(equalToConstant: 24),
            
            usernameStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            usernameStackView.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -20),
            usernameStackView.leadingAnchor.constraint(greaterThanOrEqualTo: locationStackView.trailingAnchor, constant: -20),
            usernameStackView.heightAnchor.constraint(equalToConstant: 24),
            
            locationIcon.widthAnchor.constraint(equalToConstant: 20),
            userNameIcon.widthAnchor.constraint(equalToConstant: 24),
            userNameIcon.heightAnchor.constraint(equalToConstant: 24),
            
            imageView.topAnchor.constraint(equalTo: locationStackView.bottomAnchor, constant: 20),
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

extension MainView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        mainMenu.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setup(with: mainMenu[indexPath.row])
        return cell
    }
}

extension MainView: UICollectionViewDelegateFlowLayout {
    
    private func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        
        let itemsInRow: CGFloat = 2
        let totalSpacing: CGFloat = 2 * spacing + (itemsInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / itemsInRow
        return floor(finalWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = itemWidth(for: frame.width, spacing: Constants.spacing)
        return CGSize(width: width, height: (collectionView.frame.height - 3 * Constants.spacing) / 2)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: Constants.spacing, left: Constants.spacing, bottom: Constants.spacing, right: Constants.spacing)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.cellForItem(at: indexPath) is MainCollectionViewCell {
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
