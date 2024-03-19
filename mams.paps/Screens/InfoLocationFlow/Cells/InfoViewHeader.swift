//
//  InfoHeaderLocation.swift
//  mams.paps
//
//  Created by Kos on 06.03.2024.
//



import UIKit

final class InfoViewHeader:UIView {
    
    
    //MARK: - Properties
    
        
    private lazy var categoryCount:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Eжегодный прогноз на 5 дней"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    
    //MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .customOrange
        setupHeaderCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Method
    
    private func setupHeaderCell() {
        addSubview(categoryCount)
        NSLayoutConstraint.activate([
            categoryCount.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            categoryCount.bottomAnchor.constraint(equalTo: bottomAnchor),
            categoryCount.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    func updateHeaderCount(withCount numLocation: Int) {
        self.categoryCount.text = "Найдено: \(numLocation.description) варианта"
    }
}

