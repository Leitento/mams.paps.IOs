//
//  AboutAppViewController.swift
//  mams.paps
//
//  Created by Юлия Кагирова on 14.02.2024.
//

import UIKit

final class AboutAppViewController: UIViewController, UIScrollViewDelegate {
    
    //MARK: - Enum
    
    enum Constants {
        ///120
        static let logoSize: CGFloat = 120
        ///28
        static let verticalOffset: CGFloat = 28
        ///40
        static let topVersionOffset: CGFloat = 40
        ///47
        static let topAllRightsReservedOffset: CGFloat = 47
        ///93
        static let leadingOffset: CGFloat = 93
    }
    
    //MARK: - Private Properties
    
    private lazy var backgroundView: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = LayoutConstants.cornerRadius
        view.clipsToBounds = true
        return view
    }()
    private lazy var logo: UIImageView = {
        let imageLogo = UIImageView()
        imageLogo.image = UIImage(named: "aboutAppLogo")
        imageLogo.contentMode = .scaleAspectFit
        return imageLogo
    }()
    private lazy var versionLabel: UILabel = {
        var label = UILabel()
        label.text = "AboutApp.version".localized
        label.font = Fonts.medium18 
        label.textColor = .customRed
        return label
    }()
    private lazy var descriptionName1: UILabel = {
        var label = UILabel()
        label.text = "AboutApp.description1".localized
        label.numberOfLines = 0
        label.font = Fonts.regular16
        label.textColor = .darkGray
        return label
    }()
    private lazy var descriptionName2: UILabel = {
        var label = UILabel()
        label.text = "AboutApp.description2".localized
        label.numberOfLines = 0
        label.font = Fonts.regular16
        label.textColor = .darkGray
        return label
    }()
    private lazy var allRightsReservedLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.regular18 
        label.text = "AboutApp.allRightsReserved".localized
        label.textColor = .customLightGrey
        return label
    }()
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: 300, height: 700)
        scrollView.center = view.center
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: 300, height: 800)
        scrollView.delegate = self
        scrollView.isScrollEnabled = true
        scrollView.scrollsToTop = true
        return scrollView
    }()
    private lazy var contentView = UIView()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        setupUI()
    }
    
    //MARK: - Private Methods
    
    private func setupUI() {
        createCustomNavBar(on: self, title: "AboutApp.navBar".localized)
        navigationController?.navigationBar.tintColor = .customGreyButtons
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.backgroundColor = .customOrange
        scrollView.addSubviews(contentView)
        contentView.addSubviews(backgroundView, logo, versionLabel, descriptionName1, descriptionName2, allRightsReservedLabel)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            backgroundView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                                constant: LayoutConstants.defaultOffSet),
            backgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                    constant: LayoutConstants.defaultOffSet),
            backgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                     constant: -LayoutConstants.defaultOffSet),
            backgroundView.bottomAnchor.constraint(equalTo: allRightsReservedLabel.bottomAnchor,
                                                   constant: LayoutConstants.defaultOffSet),
            
            versionLabel.topAnchor.constraint(equalTo: logo.bottomAnchor,
                                       constant: Constants.topVersionOffset),
            versionLabel.centerXAnchor.constraint(equalTo: logo.centerXAnchor),
            
            logo.topAnchor.constraint(equalTo: backgroundView.topAnchor,
                                      constant: Constants.verticalOffset),
            logo.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            logo.heightAnchor.constraint(equalToConstant: Constants.logoSize),
            logo.widthAnchor.constraint(equalToConstant: Constants.logoSize),
            
            descriptionName1.topAnchor.constraint(equalTo: versionLabel.bottomAnchor,
                                                  constant: Constants.verticalOffset),
            descriptionName1.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,
                                                      constant: LayoutConstants.defaultOffSet),
            descriptionName1.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor,
                                                       constant: -LayoutConstants.defaultOffSet),
            
            descriptionName2.topAnchor.constraint(equalTo: descriptionName1.bottomAnchor,
                                                  constant: LayoutConstants.defaultOffSet),
            descriptionName2.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,
                                                      constant: LayoutConstants.defaultOffSet),
            descriptionName2.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor,
                                                       constant: -LayoutConstants.defaultOffSet),
            
            allRightsReservedLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,
                                                 constant: Constants.leadingOffset),
            allRightsReservedLabel.topAnchor.constraint(equalTo: descriptionName2.bottomAnchor,
                                             constant: Constants.topAllRightsReservedOffset)
        ])
    }
}
