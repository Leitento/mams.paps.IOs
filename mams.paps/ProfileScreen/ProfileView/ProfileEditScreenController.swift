//
//  ProfileEditScreenController.swift
//  mams.paps
//
//  Created by Юлия Кагирова on 24.01.2024.
//

import UIKit

class ProfileEditScreenController: UIViewController {
    
    //MARK: - Properties
    
    static let id = "ProfileEditScreenController"
    
    private var profileImage: UIImageView = {
        var profileImage = UIImageView()
        profileImage.image = UIImage(systemName: "person.circle")
        profileImage.layer.cornerRadius = LayoutConstants.cornerRadius
        return profileImage
    }()

    //200 header
    //MARK: - Lify Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Private Mehtods
    
   private func setupUI() {
       view.layer.cornerRadius = LayoutConstants.cornerRadius
       view.backgroundColor = .systemBackground
       view.addSubviews(profileImage)
       NSLayoutConstraint.activate([
        profileImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 56),
        profileImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 135),
        profileImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -135),
        profileImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
        profileImage.heightAnchor.constraint(equalToConstant: 120),
        profileImage.widthAnchor.constraint(equalToConstant: 120)
       
       
       ])
    }
}
