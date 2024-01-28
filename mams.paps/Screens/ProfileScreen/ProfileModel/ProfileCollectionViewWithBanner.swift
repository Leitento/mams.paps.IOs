//
//  ProfilecollectionViewCellWithBanner.swift
//  mams.paps
//
//  Created by Юлия Кагирова on 10.01.2024.
//

import UIKit

final class ProfileCollectionViewCellWithBanner: UICollectionViewCell {
    
    //MARK: - Properties
    
    static let id = "ProfileCollectionViewCellWithBanner"
    
    private let banner: UIImageView = {
        let banner = UIImageView()
        banner.image = UIImage(named: "banner")
        banner.tintColor = .white
        banner.layer.cornerRadius = LayoutConstants.cornerRadius
        banner.clipsToBounds = true
        return banner
    }()
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Privates Methods
    
    private func setupUI() {
        addSubviews(banner)
        NSLayoutConstraint.activate([
            banner.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50), //LayoutConstants.topMargin),
            banner.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: LayoutConstants.leadingMargin),
            banner.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: LayoutConstants.trailingMargin)
        ])
    }
}
