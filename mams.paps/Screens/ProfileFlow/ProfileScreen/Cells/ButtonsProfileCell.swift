//
//  ProfileCollectionViewCell.swift
//  mams.paps
//
//  Created by Юлия Кагирова on 24.12.2023.
//

import UIKit

///button config ???????

enum SizeButtons {
    ///15
    static let fifteen: CGFloat = 15
    ///46
    static let fortySix: CGFloat = 46
    ///152
    static let oneHfiftyTwo: CGFloat = 152
    ///172
    static let oneHseventyTwo: CGFloat = 172
    ///182
    static let oneHeightyTwo: CGFloat = 182
    ///198
    static let oneHnintyEight: CGFloat = 198
    ///216
    static let twoHsixteen: CGFloat = 216
    ///217
    static let twoHseventeen: CGFloat = 217
    ///220
    static let twoHtwenty: CGFloat = 220
    ///255
    static let twoHfiftyFive: CGFloat = 255
}

final class ButtonsProfileCell: UICollectionViewCell {

    //MARK: - Private Properties
    
    weak var delegate: ProfileViewControllerDelegate?
    
    private lazy var favouriteButton: UIButton = {
        let favouriteButton = UIButton()
        favouriteButton.setTitle(ButtonsTitles.favourites, for: .normal)
        favouriteButton.setTitleColor(.customGreyButtons, for: .normal)
        favouriteButton.setImage(UIImage(named: "favourite"), for: .normal)
        favouriteButton.addTarget(self, action: #selector(favouriteButtonTapped), for: .touchUpInside)
        favouriteButton.imageEdgeInsets.left = -LayoutConstants.indentTwelve
        return favouriteButton
    }()
    
    private lazy var myAddsButton: UIButton = {
        let favouriteButton = UIButton()
        favouriteButton.setTitle(ButtonsTitles.myAdds, for: .normal)
        favouriteButton.setTitleColor(.customGreyButtons, for: .normal)
        favouriteButton.setImage(UIImage(named: "adds"), for: .normal)
        favouriteButton.addTarget(self, action: #selector(myAddsButtonTapped), for: .touchUpInside)
        favouriteButton.imageEdgeInsets.left = -LayoutConstants.indentTwelve
        return favouriteButton
    }()
    
    private lazy var notificationButton: UIButton = {
        let notificationButton = UIButton()
        notificationButton.setTitle(ButtonsTitles.notifications, for: .normal)
        notificationButton.setTitleColor(.customGreyButtons, for: .normal)
        notificationButton.setImage(UIImage(named: "notification"), for: .normal)
        notificationButton.addTarget(self, action: #selector(notificationButtonTapped), for: .touchUpInside)
        notificationButton.imageEdgeInsets.left = -LayoutConstants.indentTwelve
        return notificationButton
    }()
    
    private lazy var contractOfferButton: UIButton = {
        let contractOffer = UIButton()
        contractOffer.setTitle(ButtonsTitles.contractOffer, for: .normal)
        contractOffer.setTitleColor(.customGreyButtons, for: .normal)
        contractOffer.setImage(UIImage(named: "contractOffer"), for: .normal)
        contractOffer.addTarget(self, action: #selector(contractOfferButtonTapped), for: .touchUpInside)
        contractOffer.imageEdgeInsets.left = -LayoutConstants.indentTwelve
        return contractOffer
    }()
    private lazy var aboutAppButton: UIButton = {
        let aboutAppButton = UIButton()
        aboutAppButton.setTitle(ButtonsTitles.aboutApp, for: .normal)
        aboutAppButton.setTitleColor(.customGreyButtons, for: .normal)
        aboutAppButton.setImage(UIImage(named: "aboutApp"), for: .normal)
        aboutAppButton.addTarget(self, action: #selector(aboutAppButtonTapped), for: .touchUpInside)
        aboutAppButton.imageEdgeInsets.left = -LayoutConstants.indentTwelve
        return aboutAppButton
    }()
    private lazy var supportButton: UIButton = {
        let supportButton = UIButton()
        supportButton.setTitle(ButtonsTitles.support, for: .normal)
        supportButton.setTitleColor(.customGreyButtons, for: .normal)
        supportButton.setImage(UIImage(named: "support"), for: .normal)
        supportButton.addTarget(self, action: #selector(supportButtonTapped), for: .touchUpInside)
        supportButton.imageEdgeInsets.left = -LayoutConstants.indentTwelve
        return supportButton
    }()
    private lazy var logoutButton: UIButton = {
        let logoutButton = UIButton()
        logoutButton.setTitle(ButtonsTitles.logout, for: .normal)
        logoutButton.setTitleColor(.customGreyButtons, for: .normal)
        logoutButton.setImage(UIImage(named: "logout"), for: .normal)
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        logoutButton.imageEdgeInsets.left = -LayoutConstants.indentTwelve
        return logoutButton
    }()
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubs()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Private Methods
    
    private func setupSubs() {
        contentView.addSubviews(
            favouriteButton, myAddsButton, notificationButton, aboutAppButton, supportButton, logoutButton,
            contractOfferButton)
        contentView.backgroundColor = .white
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = LayoutConstants.cornerRadius
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.heightAnchor.constraint(equalToConstant: SizeButtons.fortySix),
            contentView.widthAnchor.constraint(equalToConstant: SizeButtons.twoHtwenty),
            contentView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
            favouriteButton.topAnchor.constraint(equalTo: contentView.topAnchor,
                                                 constant: LayoutConstants.defaultOffSet),
            favouriteButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                     constant: LayoutConstants.indentSixteen),
            favouriteButton.widthAnchor.constraint(equalToConstant: SizeButtons.oneHfiftyTwo),
            
            myAddsButton.topAnchor.constraint(equalTo: favouriteButton.bottomAnchor,
                                              constant: LayoutConstants.indentTen),
            myAddsButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                  constant: LayoutConstants.indentSixteen),
            myAddsButton.widthAnchor.constraint(equalToConstant: SizeButtons.oneHnintyEight),
            
            notificationButton.topAnchor.constraint(equalTo: myAddsButton.bottomAnchor,
                                                    constant: LayoutConstants.indentTen),
            notificationButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                        constant: LayoutConstants.indentSixteen),
            notificationButton.widthAnchor.constraint(equalToConstant: SizeButtons.oneHseventyTwo),
            
            contractOfferButton.topAnchor.constraint(equalTo: notificationButton.bottomAnchor,
                                                     constant: LayoutConstants.indentTen),
            contractOfferButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                         constant: LayoutConstants.indentSixteen),
            contractOfferButton.widthAnchor.constraint(equalToConstant: SizeButtons.twoHseventeen),
            
            aboutAppButton.topAnchor.constraint(equalTo: contractOfferButton.bottomAnchor,
                                                constant: LayoutConstants.indentTen),
            aboutAppButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                    constant: LayoutConstants.indentSixteen),
            aboutAppButton.widthAnchor.constraint(equalToConstant: SizeButtons.oneHeightyTwo),
            
            supportButton.topAnchor.constraint(equalTo: aboutAppButton.bottomAnchor,
                                               constant: LayoutConstants.indentTen),
            supportButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                   constant: LayoutConstants.indentSixteen),
            
            supportButton.widthAnchor.constraint(equalToConstant: SizeButtons.twoHfiftyFive),
            
            logoutButton.topAnchor.constraint(equalTo: supportButton.bottomAnchor,
                                              constant: LayoutConstants.indentTen),
            logoutButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                  constant: SizeButtons.fifteen),
            logoutButton.widthAnchor.constraint(equalToConstant: SizeButtons.twoHsixteen)
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
