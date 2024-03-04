import UIKit

final class InfoViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    private let alertActionSheet = AlertActionSheet.shared
    
    enum Constants {
        static let alertImage = UIImage(systemName: "ellipsis")
        static let ratingImage = UIImage(systemName: "star.fill")
        static let manImage = UIImage(systemName: "figure.walk")
    }
    
    private lazy var addressLabel: UILabel = {
        let address = UILabel()
        address.textColor = .black
        address.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return address
    }()
    
    private lazy var imagePlayGround: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.layer.cornerRadius = LayoutConstants.cornerRadius
        image.image = UIImage(named: "DeleteLater")
        return image
    }()
    
    private lazy var alertButton: UIButton = {
        let alert = UIButton()
        alert.setImage(Constants.alertImage, for: .normal)
        alert.imageView?.contentMode = .scaleAspectFit
        alert.imageEdgeInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        alert.tintColor = .lightGray
        alert.addTarget(self, action: #selector(showAlertActionSheet), for: .touchUpInside)
        return alert
    }()
    
    private lazy var categotyLabel: UILabel = {
        let categoty = UILabel()
        categoty.textColor = UIColor.customDarkBlue
        categoty.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return categoty
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let description = UILabel()
        description.textColor = .black
        description.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        description.numberOfLines = 2
        description.lineBreakMode = .byTruncatingTail
        //        description.text = "Длинный текст, который должен перенестись на вторую строку в случае необходимости"
        return description
    }()
    
    private lazy var moreDetailsButton: UIButton = {
        let moreDetail = UIButton()
        moreDetail.tintColor = UIColor.customDarkBlue
        moreDetail.setTitle("Подробнее", for: .normal)
        moreDetail.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        moreDetail.setTitleColor(UIColor.customDarkBlue, for: .normal)
        moreDetail.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return moreDetail
    }()
    
    private lazy var workingHuorsLabel: UILabel = {
        let workingHuors = UILabel()
        workingHuors.textColor = .darkGray
        workingHuors.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        workingHuors.text = "Круглосуточно"
        
        return workingHuors
    }()
    
    private lazy var raitingLabel: UILabel = {
        let raiting = UILabel()
        raiting.textColor = .white
        raiting.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return raiting
    }()
    
    private lazy var ratingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = Constants.ratingImage
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var ratingStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [raitingLabel, ratingImageView])
        stack.axis = .horizontal
        stack.spacing = 4
        stack.backgroundColor = UIColor.customRed
        stack.layer.masksToBounds = true
        stack.layer.cornerRadius = 18
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    private lazy var wolkImage: UIImageView = {
        let wolkImage = UIImageView()
        wolkImage.contentMode = .scaleAspectFit
        wolkImage.image = Constants.manImage
        wolkImage.tintColor = .black
        return wolkImage
    }()
    
    private lazy var longToGoLabel: UILabel = {
        let longToGo = UILabel()
        longToGo.textColor = .black
        longToGo.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        longToGo.text = "15 мин"
        
        return longToGo
    }()
    
    private lazy var distanceLabel: UILabel = {
        let distance = UILabel()
        distance.textColor = .darkGray
        distance.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        distance.text = "1.5км"
        
        return distance
    }()
    
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layer.cornerRadius = 30
        layer.masksToBounds = true
        setupCollectionCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Method
    
    private func setupCollectionCell() {
        contentView.backgroundColor = .white
        contentView.addSubviews(imagePlayGround, addressLabel, alertButton, categotyLabel, descriptionLabel,
                                moreDetailsButton, ratingStackView, workingHuorsLabel, wolkImage, longToGoLabel,
                                distanceLabel, translatesAutoresizingMaskIntoConstraints: false)
        NSLayoutConstraint.activate([
            imagePlayGround.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutConstants.spacing15),
            imagePlayGround.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -LayoutConstants.spacing15),
            imagePlayGround.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.indent),
            imagePlayGround.widthAnchor.constraint(equalToConstant: 120),
            
            addressLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutConstants.spacing15),
            addressLabel.leadingAnchor.constraint(equalTo: imagePlayGround.trailingAnchor, constant: LayoutConstants.indent),
            addressLabel.trailingAnchor.constraint(equalTo: alertButton.leadingAnchor, constant: -LayoutConstants.indent),
            
            alertButton.widthAnchor.constraint(equalToConstant: 28),
            alertButton.centerYAnchor.constraint(equalTo: addressLabel.centerYAnchor),
            alertButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -LayoutConstants.indent),
            
            categotyLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: LayoutConstants.indent),
            categotyLabel.leadingAnchor.constraint(equalTo: imagePlayGround.trailingAnchor, constant: LayoutConstants.indent),
            
            descriptionLabel.topAnchor.constraint(equalTo: categotyLabel.bottomAnchor, constant: LayoutConstants.indent),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 170),
            descriptionLabel.leadingAnchor.constraint(equalTo: imagePlayGround.trailingAnchor, constant: LayoutConstants.indent),
            
            moreDetailsButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            moreDetailsButton.widthAnchor.constraint(equalToConstant: 70),
            moreDetailsButton.heightAnchor.constraint(equalToConstant: 13),
            moreDetailsButton.leadingAnchor.constraint(equalTo: imagePlayGround.trailingAnchor, constant: LayoutConstants.indent),
            
            ratingStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -LayoutConstants.spacing15),
            ratingStackView.leadingAnchor.constraint(equalTo: imagePlayGround.trailingAnchor, constant: LayoutConstants.indent),
            ratingStackView.heightAnchor.constraint(equalToConstant: 34),
            
            workingHuorsLabel.bottomAnchor.constraint(equalTo: ratingStackView.topAnchor, constant: -20),
            workingHuorsLabel.leadingAnchor.constraint(equalTo: imagePlayGround.trailingAnchor, constant: LayoutConstants.indent),
            
            wolkImage.centerYAnchor.constraint(equalTo: ratingStackView.centerYAnchor),
            wolkImage.leadingAnchor.constraint(equalTo: ratingStackView.trailingAnchor, constant: 15),
            wolkImage.heightAnchor.constraint(equalToConstant: 28),
            wolkImage.widthAnchor.constraint(equalToConstant: 28),
            
            longToGoLabel.leadingAnchor.constraint(equalTo: wolkImage.trailingAnchor, constant: 1),
            longToGoLabel.centerYAnchor.constraint(equalTo: wolkImage.centerYAnchor),
            
            distanceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -LayoutConstants.indent),
            distanceLabel.centerYAnchor.constraint(equalTo: wolkImage.centerYAnchor),
        ])
    }
    
    
    func configurationCellCollection(with location: Location) {
        self.addressLabel.text = location.address
        self.categotyLabel.text = location.category?.title
        self.descriptionLabel.text = location.description
        self.raitingLabel.text = String(describing: location.rating ?? 0)
    }
    
    @objc private func showAlertActionSheet() {
        if let parentVC = parentViewController {
            alertActionSheet.showAlertActionSheet(on: parentVC, title: "Выберите действие ", message: nil)
        }
    }
}


