//
//  ContractOfferViewController.swift
//  mams.paps
//
//  Created by Юлия Кагирова on 14.02.2024.
//

import UIKit

class ContractOfferViewController: UIViewController, UIScrollViewDelegate {
    
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
        label.preferredMaxLayoutWidth = UIScreen.main.bounds.width - 16
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
        return label
    }()
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: 300, height: 400)
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
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        setupUI()
        descriptionName.frame.size = scrollView.contentSize
        scrollView.contentOffset = CGPoint(x: 150, y: 150)
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubviews(backgroundView, label, descriptionName)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),
            
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor,
                                                constant: LayoutConstants.defaultOffSet),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, 
                                                    constant: LayoutConstants.defaultOffSet),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, 
                                                     constant: -LayoutConstants.defaultOffSet),

            label.topAnchor.constraint(equalTo: backgroundView.topAnchor, 
                                       constant: LayoutConstants.defaultOffSet),
            label.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, 
                                           constant: LayoutConstants.indentSixteen),
            
            descriptionName.topAnchor.constraint(equalTo: label.bottomAnchor, constant: LayoutConstants.indentEight),
            descriptionName.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 4)
            
        ])
    }
}
