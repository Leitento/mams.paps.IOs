import UIKit

final class InfoViewCellFilter: UICollectionViewCell {
    
    //MARK: - Properties
    

    enum Constants {
        static let arrowImage = UIImage(systemName: "play.fill")
    }
    
    private lazy var categotyLabel: UILabel = {
        let categoty = UILabel()
        categoty.textColor = .black
        categoty.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return categoty
    }()
    
    private lazy var imageArrrow: UIImageView = {
        let image = UIImageView(image: Constants.arrowImage)
        image.tintColor = UIColor.customSkin
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var border: UIView = {
        let border = UIView(frame: frame)
        border.backgroundColor = UIColor.customSkin
        return border
    }()
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .white
        setupCollectionCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Method
    
    private func setupCollectionCell() {
        contentView.backgroundColor = .white
        contentView.addSubviews(border, categotyLabel, imageArrrow, translatesAutoresizingMaskIntoConstraints: false)
        NSLayoutConstraint.activate([
            imageArrrow.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageArrrow.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageArrrow.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.indent),
            imageArrrow.widthAnchor.constraint(equalToConstant: 22),

            
            categotyLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            categotyLabel.leadingAnchor.constraint(equalTo: imageArrrow.trailingAnchor, constant: LayoutConstants.indent),
            categotyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -LayoutConstants.indent),
            
            border.topAnchor.constraint(equalTo: contentView.topAnchor),
            border.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.spacing15),
            border.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -LayoutConstants.spacing15),
            border.heightAnchor.constraint(equalToConstant: 0.5),
        ])
    }
    
    func configurationCellCollection(with location: Category) {
        self.categotyLabel.text = location.title
        
    }
}


