
//
//  AboutAppViewController.swift
//  mams.paps
//
//  Created by Юлия Кагирова on 14.02.2024.
//

import UIKit

final class AboutAppViewController: UIViewController, UIScrollViewDelegate {
    
    //MARK: - Private Properties
    
     weak var profileCoordinator: ProfileScreenCoordinator?

    private lazy var backgroundView: UIView = {
        var view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = LayoutConstants.cornerRadius
        return view
    }()
    private lazy var logo: UIImageView = {
        let imageLogo = UIImageView()
        imageLogo.image = UIImage(named: "aboutAppLogo")
        imageLogo.translatesAutoresizingMaskIntoConstraints = false
        imageLogo.contentMode = .scaleAspectFit
        imageLogo.tintColor = .white
        return imageLogo
    }()
    private var label: UILabel = {
        var label = UILabel()
        label.text = "AboutApp.version".localized
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .customRed
        return label
    }()
    private var descriptionName: UILabel = {
        var label = UILabel()
        label.text = "AboutApp.description".localized
        label.numberOfLines = 0
//        label.preferredMaxLayoutWidth = UIScreen.main.bounds.width - 45
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
//        scrollView.frame = CGRect(x: 0, y: 0, width: 300, height: 400)
        scrollView.center = view.center
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.contentSize = CGSize(width: 300, height: 800)
        scrollView.delegate = self
        scrollView.isScrollEnabled = true
        scrollView.scrollsToTop = true
        return scrollView
    }()
    private lazy var contentView = UIView()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        setupUI()
//        descriptionName.frame.size = scrollView.contentSize
//        scrollView.contentOffset = CGPoint(x: 150, y: 150)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: - Private Methods
    
    private func setupUI() {
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(
            title: "О приложении",
            style: .done,
            target: self,
            action: nil)
        navigationController?.navigationBar.tintColor = .customGrey
        view.backgroundColor = .customOrange

        view.addSubview(scrollView)
        scrollView.addSubviews(contentView)
        contentView.addSubviews(backgroundView, logo, label, descriptionName, rightsLabel)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            backgroundView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                                constant: LayoutConstants.defaultOffSet),
            backgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                    constant: LayoutConstants.defaultOffSet),
            backgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                     constant: -LayoutConstants.defaultOffSet),
            
            label.topAnchor.constraint(equalTo: backgroundView.topAnchor,
                                       constant: 188),
            label.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,
                                           constant: 74),
            
            logo.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 28),
            logo.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 115),
            
            descriptionName.topAnchor.constraint(equalTo: backgroundView.topAnchor,
                                                 constant: 239),
            descriptionName.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,
                                                     constant: LayoutConstants.defaultOffSet),
            descriptionName.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -LayoutConstants.defaultOffSet),
            
            rightsLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 93),
            rightsLabel.topAnchor.constraint(equalTo: descriptionName.bottomAnchor, constant: 47)
            
        ])
    }
}
