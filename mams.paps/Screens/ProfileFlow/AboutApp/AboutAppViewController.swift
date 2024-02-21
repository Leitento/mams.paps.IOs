//
//  AboutAppViewController.swift
//  mams.paps
//
//  Created by Юлия Кагирова on 14.02.2024.
//

import UIKit

enum Size {
    ///120
    static let logoHeight: CGFloat = 120
    ///120
    static let logoWidth: CGFloat = 120
    ///28
    static let twentyEight: CGFloat = 28
    ///40
    static let forty: CGFloat = 40
    ///47
    static let fortySeven: CGFloat = 47
    ///74
    static let seventyFour: CGFloat = 74
    ///93
    static let nintyThree: CGFloat = 93
}

final class AboutAppViewController: UIViewController, UIScrollViewDelegate {
    
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
    private lazy var label: UILabel = {
        var label = UILabel()
        label.text = "AboutApp.version".localized
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .customRed
        return label
    }()
    private lazy var descriptionName1: UILabel = {
        var label = UILabel()
        label.text = "AboutApp.description1".localized
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .darkGray
        return label
    }()
    private lazy var descriptionName2: UILabel = {
        var label = UILabel()
        label.text = "AboutApp.description2".localized
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .darkGray
        return label
    }()
    private lazy var rightsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "AboutApp.rights".localized
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
        createCustomNavBar(on: self, title: "О приложении")
        navigationController?.navigationBar.tintColor = .customGrey
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.backgroundColor = .customOrange
        scrollView.addSubviews(contentView)
        contentView.addSubviews(backgroundView, logo, label, descriptionName1, descriptionName2, rightsLabel)
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
            backgroundView.bottomAnchor.constraint(equalTo: rightsLabel.bottomAnchor,
                                                   constant: LayoutConstants.defaultOffSet),
            
            label.topAnchor.constraint(equalTo: logo.bottomAnchor,
                                       constant: Size.forty),
            label.centerXAnchor.constraint(equalTo: logo.centerXAnchor),
            
            logo.topAnchor.constraint(equalTo: backgroundView.topAnchor,
                                      constant: Size.twentyEight),
            logo.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            logo.heightAnchor.constraint(equalToConstant: Size.logoHeight),
            logo.widthAnchor.constraint(equalToConstant: Size.logoWidth),
            
            descriptionName1.topAnchor.constraint(equalTo: label.bottomAnchor,
                                                  constant: Size.twentyEight),
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
            
            rightsLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,
                                                 constant: Size.nintyThree),
            rightsLabel.topAnchor.constraint(equalTo: descriptionName2.bottomAnchor,
                                             constant: Size.fortySeven)
        ])
    }
}
