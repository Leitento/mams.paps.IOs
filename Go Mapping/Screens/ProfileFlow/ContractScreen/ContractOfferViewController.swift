//
//  ContractOfferViewController.swift
//  mams.paps
//
//  Created by Юлия Кагирова on 14.02.2024.
//

import UIKit

final class ContractOfferViewController: UIViewController, UIScrollViewDelegate {
    
    //MARK: - Private Properties
    
    private lazy var backgroundView: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = LayoutConstants.cornerRadius
        view.clipsToBounds = true
        return view
    }()
    private lazy var label: UILabel = {
        var label = UILabel()
        label.text = "ContractOffer.label".localized
        label.font = Fonts.medium18
        label.textColor = .customRed
        return label
    }()
    private lazy var descriptionName1: UILabel = {
        var label = UILabel()
        label.text = "ContractOffer.termin1".localized
        label.numberOfLines = 0
        label.font = Fonts.regular14
        label.textColor = .darkGray
        return label
    }()
    private lazy var descriptionName2: UILabel = {
        var label = UILabel()
        label.text = "ContractOffer.termin2".localized
        label.numberOfLines = 0
        label.font = Fonts.regular14
        label.textColor = .darkGray
        return label
    }()
    private lazy var descriptionName3: UILabel = {
        var label = UILabel()
        label.text = "ContractOffer.termin3".localized
        label.numberOfLines = 0
        label.font = Fonts.regular14
        label.textColor = .darkGray
        return label
    }()
    private lazy var descriptionName4: UILabel = {
        var label = UILabel()
        label.text = "ContractOffer.termin4".localized
        label.numberOfLines = 0
        label.font = Fonts.regular14
        label.textColor = .darkGray
        return label
    }()
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
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
        setCustomBackBarItem(title:"ContractOffer.navBar".localized)

        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.backgroundColor = .customOrange
        scrollView.addSubviews(contentView)
        contentView.addSubviews(backgroundView, label, descriptionName1, descriptionName2, descriptionName3, descriptionName4)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentView.heightAnchor.constraint(equalTo: backgroundView.heightAnchor,
                                                constant: LayoutConstants.defaultOffSet),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor,
                                                constant: -LayoutConstants.defaultOffSet),
            
            backgroundView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                                constant: LayoutConstants.defaultOffSet),
            backgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                    constant: LayoutConstants.defaultOffSet),
            backgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                     constant: -LayoutConstants.defaultOffSet),
            backgroundView.bottomAnchor.constraint(equalTo: descriptionName4.bottomAnchor,
                                                   constant: LayoutConstants.defaultOffSet),
            
            label.topAnchor.constraint(equalTo: backgroundView.topAnchor,
                                       constant: LayoutConstants.defaultOffSet),
            label.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,
                                           constant: LayoutConstants.indentSixteen),
            
            descriptionName1.topAnchor.constraint(equalTo: label.bottomAnchor,
                                                  constant: LayoutConstants.indentEight),
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
            
            descriptionName3.topAnchor.constraint(equalTo: descriptionName2.bottomAnchor,
                                                  constant: LayoutConstants.defaultOffSet),
            descriptionName3.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,
                                                      constant: LayoutConstants.defaultOffSet),
            descriptionName3.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor,
                                                       constant: -LayoutConstants.defaultOffSet),
            
            descriptionName4.topAnchor.constraint(equalTo: descriptionName3.bottomAnchor,
                                                  constant: LayoutConstants.defaultOffSet),
            descriptionName4.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,
                                                      constant: LayoutConstants.defaultOffSet),
            descriptionName4.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor,
                                                       constant: -LayoutConstants.defaultOffSet)
        ])
    }
}
