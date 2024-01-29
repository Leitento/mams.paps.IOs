//
//  ProfileHeaderView.swift
//  mams.paps
//
//  Created by Юлия Кагирова on 10.01.2024.
//

import UIKit

final class ProfileHeaderView: UICollectionViewCell {
    
    //MARK: - Properties
    
    static let id = "ProfileHeaderView"
    
    private var profileImage: UIImageView = {
        var profileImage = UIImageView()
        profileImage.image = UIImage(systemName: "person.circle")
        profileImage.layer.cornerRadius = LayoutConstants.cornerRadius
        return profileImage
    }()
    private var nameLabel: UILabel = {
        var nameLabel = UILabel()
        nameLabel.text = "Фамилия Имя"
        nameLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        nameLabel.textColor = .black
        nameLabel.textAlignment = .left
        return nameLabel
    }()
    private var cityLabel: UILabel = {
        var cityLabel = UILabel()
        cityLabel.text = "Город"
        cityLabel.font = .systemFont(ofSize: 14, weight: .medium)
        cityLabel.textColor = .black
        cityLabel.textAlignment = .left
        return cityLabel
    }()
    private var cityIcon: UIImageView = {
        var cityIcon = UIImageView()
        cityIcon.image = UIImage(named: "cityIcon")
        return cityIcon
    }()
    private var mailIcon: UIImageView = {
        var mailIcon = UIImageView()
        mailIcon.image = UIImage(named: "mailIcon")
        return mailIcon
    }()
    private var mailLabel: UILabel = {
        var mailLabel = UILabel()
        mailLabel.text = "mail.mail@mail.ru"
        mailLabel.font = .systemFont(ofSize: 14, weight: .medium)
        mailLabel.textColor = .black
        mailLabel.textAlignment = .left
        return mailLabel
    }()
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame )
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configuredCell(profile: ProfileModel) {
        nameLabel.text = "\(profile.name)" + " " + "\(profile.secondName)"
        cityLabel.text = "\(profile.city)" 
        mailLabel.text = "\(profile.email)"
    }
    
    //MARK: - Private Mehtods
    
    func setupUI() {
        self.layer.cornerRadius = LayoutConstants.cornerRadius
        self.backgroundColor = .white
        addSubviews(nameLabel, profileImage, cityLabel, cityIcon, mailLabel, mailIcon)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor,
                                           constant: 22),
            nameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor,
                                           constant: LayoutConstants.leadingMargin),
            
            profileImage.topAnchor.constraint(equalTo: topAnchor,
                                           constant: LayoutConstants.bottomMargin),
            profileImage.leadingAnchor.constraint(equalTo: leadingAnchor,
                                           constant: LayoutConstants.bottomMargin),
            profileImage.bottomAnchor.constraint(equalTo: bottomAnchor,
                                           constant: -LayoutConstants.bottomMargin),
            profileImage.widthAnchor.constraint(equalToConstant: 120),
            profileImage.heightAnchor.constraint(equalToConstant: 120),
            
            cityLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,
                                           constant: LayoutConstants.leadingMargin),
            cityLabel.leadingAnchor.constraint(equalTo: cityIcon.trailingAnchor,
                                           constant: LayoutConstants.indentSix),
            
            cityIcon.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,
                                           constant: LayoutConstants.indentEight),
            cityIcon.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor,
                                           constant: LayoutConstants.leadingMargin),
            
            mailIcon.topAnchor.constraint(equalTo: cityIcon.bottomAnchor,
                                           constant: LayoutConstants.indentEight),
            mailIcon.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor,
                                           constant: LayoutConstants.leadingMargin),
            
            mailLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor,
                                           constant: LayoutConstants.leadingMargin),
            mailLabel.leadingAnchor.constraint(equalTo: mailIcon.trailingAnchor,
                                           constant: LayoutConstants.indentSix),
        ])
    }
}
