//
//  ActivityIndicator.swift
//  mams.paps
//
//  Created by  Кос on 27.02.2024.
//

import UIKit

final class ActivityIndicator: UIView {
    
    
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.tintColor = .white
        return activityIndicator
    }()
    
    private lazy var activityIndicatorBackground: UIView = {
        let loader = UIView()
        loader.backgroundColor = .black
        loader.alpha = 0
        return loader
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func activityIndicatorEnabled(_ isTrue: Bool) {
        switch isTrue {
        case true:
//            DispatchQueue.main.async {
                self.activityIndicator.startAnimating()
                self.activityIndicatorBackground.alpha = 1
//            }
        case false:
            activityIndicator.stopAnimating()
            activityIndicatorBackground.alpha = 0
        }
    }
    
    private func setupUI() {
        addSubviews(activityIndicatorBackground, activityIndicator, translatesAutoresizingMaskIntoConstraints: false)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            
            activityIndicatorBackground.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            activityIndicatorBackground.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            activityIndicatorBackground.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            activityIndicatorBackground.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}
