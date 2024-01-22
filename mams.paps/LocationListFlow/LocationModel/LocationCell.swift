//  LocationCell.swift
//  mams.paps
//  Created by Юлия Кагирова on 21.12.2023.

import UIKit

final class LocationCell: UICollectionViewCell {

    //MARK: - Properties
    
    private var photo: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    private var title: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 12, weight: .regular)
        title.text = "LocationCell.title".localized
        title.textColor = .black
        return title
    }()
    private var adress: UILabel = {
        let adress = UILabel()
        adress.font = .systemFont(ofSize: 14, weight: .medium)
        adress.text = "LocationCell.adress".localized
        adress.textColor = .black
        return adress
    }()
    private var longDescription: UILabel = {
        let description = UILabel()
        description.font = .systemFont(ofSize: 11, weight: .regular)
        description.text = "LocationCell.longDescription".localized
        description.textColor = .black
        description.numberOfLines = 0
        return description
    }()
    private var rating: UILabel = {
        let rating = UILabel()
        rating.font = .systemFont(ofSize: 24, weight: .medium)
        rating.text = "Location.rating".localized
        rating.textColor = .black
        return rating
    }()
    private var starPic: UIImage = {
        let starPic = UIImage(named: "star.fill")!
        return starPic
    }()
    private var timeToWalk: UILabel = {
        let timeToWalk = UILabel()
        timeToWalk.font = .systemFont(ofSize: 18, weight: .bold)
        timeToWalk.text = "LocationCell.timeToWalk".localized
        timeToWalk.textColor = .black
        return timeToWalk
    }()
    private var kilometres: UILabel = {
        let kilometres = UILabel()
        kilometres.font = .systemFont(ofSize: 18, weight: .regular)
        kilometres.text = "LocationCell.kilometres".localized
        kilometres.textColor = .black
        return kilometres
    }()
    private lazy var remember: UIButton = {
        let remember = UIButton(frame: .zero)
        remember.setImage(UIImage(named: "bookmark"), for: .normal)
        remember.addTarget(self, action: #selector(rememberButton), for: .touchUpInside)
        remember.clipsToBounds = true
        return remember
    }()
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("Error")
    }

    //MARK: - Private Methods
    
    private func setupConstraints() {
        addSubviews(photo, title, adress, longDescription, rating, timeToWalk, kilometres, remember)
        
        NSLayoutConstraint.activate([
            photo.topAnchor.constraint(equalTo: contentView.topAnchor),
            photo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            title.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            adress.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            adress.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            longDescription.topAnchor.constraint(equalTo: adress.bottomAnchor, constant: 15),
            longDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            rating.topAnchor.constraint(equalTo: longDescription.bottomAnchor, constant: 15),
            rating.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            timeToWalk.topAnchor.constraint(equalTo: longDescription.bottomAnchor, constant: 15),
            timeToWalk.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            kilometres.topAnchor.constraint(equalTo: longDescription.bottomAnchor, constant: 15),
            kilometres.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            remember.topAnchor.constraint(equalTo: title.bottomAnchor),
            remember.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }

    @objc private func rememberButton() {
        //при нажатии должна сохранить локацию в избранных и покраситься в желтый
    }
}
