//
//  ProfileCollectionViewCell.swift
//  mams.paps
//
//  Created by Юлия Кагирова on 24.12.2023.
//

import UIKit

final class ProfileCollectionViewCell: UICollectionViewCell {

    //MARK: - Private Properties

    static let id = "ProfileCollectionViewCell"

    private lazy var favouriteButton: UIButton = {
        let favouriteButton = UIButton()
        favouriteButton.setTitle(ButtonsTitles.favourites, for: .normal)
        favouriteButton.setTitleColor(.customGreyButtons, for: .normal)
        favouriteButton.setImage(UIImage(named: "favourite"), for: .normal)
        favouriteButton.addTarget(self, action: #selector(favouriteButtonTapped), for: .touchUpInside)
        favouriteButton.imageEdgeInsets.left = -12
//        favouriteButton.titleEdgeInsets.left = 12
        return favouriteButton
    }()

    private lazy var notificationButton: UIButton = {
        let notificationButton = UIButton()
        notificationButton.setTitle(ButtonsTitles.notifications, for: .normal)
        notificationButton.setTitleColor(.customGreyButtons, for: .normal)
        notificationButton.setImage(UIImage(named: "notification"), for: .normal)
        notificationButton.addTarget(self, action: #selector(notificationButtonTapped), for: .touchUpInside)
        notificationButton.imageEdgeInsets.left = -12
//        notificationButton.titleEdgeInsets.left = 12
        return notificationButton
    }()

    private lazy var contractOfferButton: UIButton = {
        let contractOffer = UIButton()
        contractOffer.setTitle(ButtonsTitles.contractOffer, for: .normal)
        contractOffer.setTitleColor(.customGreyButtons, for: .normal)
        contractOffer.setImage(UIImage(named: "contractOffer"), for: .normal)
        contractOffer.addTarget(self, action: #selector(contractOfferButtonTapped), for: .touchUpInside)
        contractOffer.imageEdgeInsets.left = -12
//        contractOffer.titleEdgeInsets.left = 12
        return contractOffer
    }()
    private lazy var aboutAppButton: UIButton = {
        let aboutAppButton = UIButton()
        aboutAppButton.setTitle(ButtonsTitles.aboutApp, for: .normal)
        aboutAppButton.setTitleColor(.customGreyButtons, for: .normal)
        aboutAppButton.setImage(UIImage(named: "aboutApp"), for: .normal)
        aboutAppButton.addTarget(self, action: #selector(aboutAppButtonTapped), for: .touchUpInside)
        aboutAppButton.imageEdgeInsets.left = -12
//        aboutAppButton.titleEdgeInsets.left = 12
        return aboutAppButton
    }()
    private lazy var supportButton: UIButton = {
        let supportButton = UIButton()
        supportButton.setTitle(ButtonsTitles.support, for: .normal)
        supportButton.setTitleColor(.customGreyButtons, for: .normal)
        supportButton.setImage(UIImage(named: "support"), for: .normal)
        supportButton.addTarget(self, action: #selector(supportButtonTapped), for: .touchUpInside)
        supportButton.imageEdgeInsets.left = -12
//        supportButton.titleEdgeInsets.left = 12
        return supportButton
    }()
    private lazy var logoutButton: UIButton = {
        let logoutButton = UIButton()
        logoutButton.setTitle(ButtonsTitles.logout, for: .normal)
        logoutButton.setTitleColor(.customGreyButtons, for: .normal)
        logoutButton.setImage(UIImage(named: "logout"), for: .normal)
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        logoutButton.imageEdgeInsets.left = -12
//        logoutButton.titleEdgeInsets.left = 12
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



private func setupSubs() {
        contentView.addSubviews(
            favouriteButton,notificationButton,aboutAppButton,supportButton,logoutButton,contractOfferButton
        )
        contentView.backgroundColor = .white
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = LayoutConstants.cornerRadius
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 46),
            contentView.widthAnchor.constraint(equalToConstant: 220),
            contentView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),

            favouriteButton.topAnchor.constraint(equalTo: contentView.topAnchor,
                                                 constant: LayoutConstants.defaultOffSet),
            favouriteButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.indentSixteen),
//            favouriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
//                                            constant: -LayoutConstants.indentSix),
            favouriteButton.widthAnchor.constraint(equalToConstant: 158),//156

            notificationButton.topAnchor.constraint(equalTo: favouriteButton.bottomAnchor,
                                                 constant: LayoutConstants.indent),
            notificationButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.indentSixteen),
//            notificationButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                                                         //constant: -LayoutConstants.indentTwelve),//def
            notificationButton.widthAnchor.constraint(equalToConstant: 170),//174

            contractOfferButton.topAnchor.constraint(equalTo: notificationButton.bottomAnchor,
                                                 constant: LayoutConstants.indent),
            contractOfferButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.indentSixteen),
//            contractOfferButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                                                          //constant: -LayoutConstants.indentTwelve),//def
            contractOfferButton.widthAnchor.constraint(equalToConstant: 217),//215
            aboutAppButton.topAnchor.constraint(equalTo: contractOfferButton.bottomAnchor,
                                                constant: LayoutConstants.indent),
            aboutAppButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.indentSixteen),
//            aboutAppButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                                                    // constant: -LayoutConstants.indentTwelve),//def

            aboutAppButton.widthAnchor.constraint(equalToConstant: 182),
            supportButton.topAnchor.constraint(equalTo: aboutAppButton.bottomAnchor,
                                                constant: LayoutConstants.indent),
            supportButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.indentSixteen),
//            supportButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                                                    //constant: -LayoutConstants.indentTwelve),//def

supportButton.widthAnchor.constraint(equalToConstant: 255),//219//235
            logoutButton.topAnchor.constraint(equalTo: supportButton.bottomAnchor,
                                               constant: LayoutConstants.indent),
            logoutButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.indentSixteen),
//            logoutButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                                                  // constant: -LayoutConstants.indentTwelve),//def
            logoutButton.widthAnchor.constraint(equalToConstant: 220),//210
        ])
    }

    //MARK: - Events Handler

    @objc private func favouriteButtonTapped() {
        print("favouriteButtonTapped")
    }

    @objc private func notificationButtonTapped() {
        print("notificationButtonTapped")
    }

    @objc private func contractOfferButtonTapped() {
        print("contractOfferButtonTapped")
    }

    @objc private func aboutAppButtonTapped() {
        print("aboutAppButtonTapped")
    }

    @objc private func supportButtonTapped() {
        print("supportButtonTapped")
    }

    @objc private func logoutButtonTapped() {
        print("logoutButtonTapped")
    }
}
