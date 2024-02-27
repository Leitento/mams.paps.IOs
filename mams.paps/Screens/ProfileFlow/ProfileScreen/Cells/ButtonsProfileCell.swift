//
//  ProfileCollectionViewCell.swift
//  mams.paps
//
//  Created by Юлия Кагирова on 24.12.2023.
//

import UIKit

final class ButtonsProfileCell: UICollectionViewCell {
    
    //MARK: - Enum
    
    enum SizeButtons {
        static let imageSize: CGFloat = 46
    }
    
    //MARK: - Private Properties
    
    weak var delegate: ProfileViewControllerDelegate?
    
    private lazy var image: UIImageView = {
        let view = UIImageView()
        return view
    }()
    private lazy var label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    func configuredCell(button: ButtonsModel) {
        image.image = button.icon
        label.text = button.title
        
        switch button.target {
        case .favourites:
            layer.cornerRadius = 30
            layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        case .logout:
            layer.cornerRadius = 30
            layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            NSLayoutConstraint.activate([
                image.bottomAnchor.constraint(
                    equalTo: bottomAnchor,
                    constant: -LayoutConstants.defaultOffSet
                )
            ])
        default:
            break
        }
    }
    
    //MARK: - Private Methods
    
    private func setupViews() {
        backgroundColor = .white
        addSubviews(label, image)
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor,
                                       constant: LayoutConstants.defaultOffSet),
            image.leadingAnchor.constraint(equalTo: leadingAnchor,
                                           constant: LayoutConstants.defaultOffSet),
            image.heightAnchor.constraint(equalToConstant: SizeButtons.imageSize),
            image.widthAnchor.constraint(equalToConstant: SizeButtons.imageSize),
            label.centerYAnchor.constraint(equalTo: image.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: image.trailingAnchor,
                                           constant: LayoutConstants.defaultOffSet)
        ])
    }
    
    //MARK: - Event Handlers
    
    @objc private func favouriteButtonTapped() {
        delegate?.favouriteButtonTapped()
    }
    @objc private func myAddsButtonTapped() {
        delegate?.myAddsButtonTapped()
    }
    @objc private func notificationButtonTapped() {
        delegate?.notificationButtonTapped()
    }
    @objc private func contractOfferButtonTapped() {
        delegate?.contactOfferButtonTapped()
    }
    @objc private func aboutAppButtonTapped() {
        delegate?.aboutAppButtonTapped()
    }
    @objc private func supportButtonTapped() {
        delegate?.supportButtonTapped()
    }
    @objc private func logoutButtonTapped() {
        delegate?.logoutButtonTapped()
    }
}
