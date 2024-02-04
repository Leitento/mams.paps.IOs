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
    
    private lazy var icon: UIImageView = {
        var icon = UIImageView()
        icon.tintColor = UIColor.customRed
        return icon
    }()
    
    private lazy var label: UILabel = {
        var label = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    private lazy var list: UICollectionViewListCell = {
        let list = UICollectionViewListCell()
        
        return list
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

        self.contentView.addSubviews(icon,label)
        contentView.backgroundColor = .white
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = LayoutConstants.cornerRadius
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100),
            contentView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: LayoutConstants.leadingMargin),
            contentView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 320),
            contentView.heightAnchor.constraint(equalToConstant: 300),
//            contentView.widthAnchor.constraint(equalToConstant: frame.width),
            contentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: LayoutConstants.bottomMargin),
            
            icon.topAnchor.constraint(equalTo: contentView.topAnchor,constant: LayoutConstants.topMargin),
            icon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.leadingMargin),
            
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 35),
            label.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: LayoutConstants.leadingMargin)
        ])
    }
}

//list.count
