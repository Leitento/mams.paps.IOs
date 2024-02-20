//
//  ContractOfferViewController.swift
//  mams.paps
//
//  Created by Юлия Кагирова on 14.02.2024.
//

import UIKit

final class ContractOfferViewController: UIViewController, UIScrollViewDelegate {
    
    //MARK: - Private Properties
    
    private var backgroundView: UIView = {
        var view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = LayoutConstants.cornerRadius
        return view
    }()
    private var label: UILabel = {
        var label = UILabel()
        label.text = "ContractOffer.label".localized
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .customRed
        return label
    }()
    private var descriptionName: UILabel = {
        var label = UILabel()
        label.text = "ContractOffer.termins".localized
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = UIScreen.main.bounds.width - 40
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
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
            title: "Публичная оферта",
            style: .done,
            target: self,
            action: nil)
        navigationController?.navigationBar.tintColor = .customGrey
        view.backgroundColor = .customOrange
        view.addSubview(scrollView)
        scrollView.addSubviews(contentView)
        contentView.addSubviews(backgroundView, label, descriptionName)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            backgroundView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                                constant: LayoutConstants.defaultOffSet),
            backgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                    constant: LayoutConstants.defaultOffSet),
            backgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                     constant: -LayoutConstants.defaultOffSet),
            
            label.topAnchor.constraint(equalTo: backgroundView.topAnchor,
                                       constant: LayoutConstants.defaultOffSet),
            label.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,
                                           constant: LayoutConstants.indentSixteen),
            
            descriptionName.topAnchor.constraint(equalTo: label.bottomAnchor, constant: LayoutConstants.indentEight),
            descriptionName.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 4),
            
            contentView.bottomAnchor.constraint(equalTo: contentView.subviews.last?.bottomAnchor ?? scrollView.bottomAnchor,
                                                constant: -LayoutConstants.defaultOffSet)
            
        ])
    }
}
