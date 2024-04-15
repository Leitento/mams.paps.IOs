//
//  ProfileEditScreenController.swift
//  mams.paps
//
//  Created by Юлия Кагирова on 29.01.2024.
//

import UIKit
import PhotosUI

final class ProfileEditScreenController: UIViewController {
    
    //MARK: - Enum
    
    enum SizeEditScreen {
        static let verticalOffset: CGFloat = 28
        static let labelLeading: CGFloat = 30
        static let buttonTopOffset: CGFloat = 40
        static let fieldHeight: CGFloat = 48
        static let buttonHeight: CGFloat = 60
        static let imageTopOffset: CGFloat = 100
        static let buttonBottomOffset: CGFloat = 108
        static let photoImage: CGFloat = 120
        static let backgroundHeight: CGFloat = 245
        static let fieldWidth: CGFloat = 318
        static let buttonWidth: CGFloat = 350
    }

    //MARK: - Properties
   
    private var profile: Profile
    
    private lazy var viewBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = LayoutConstants.cornerRadius
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var viewList: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = LayoutConstants.cornerRadius
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var photoEditImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .label
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var nameField = ProfileTextField(placeholder: profile.profileUser.name)
    private lazy var surnameField = ProfileTextField(placeholder: profile.profileUser.secondName)
    private lazy var cityField = ProfileTextField(placeholder: profile.profileUser.city)
    private lazy var emailField = ProfileTextField(placeholder: profile.profileUser.email)
    private lazy var phoneField = ProfileTextField(placeholder: profile.profileUser.telephone)
    private lazy var dateOfBirthField = ProfileTextField(placeholder: profile.profileUser.dateOfBirth)
    
    private lazy var nameLabel = ProfileLabel(label: "ProfileEditScreenLabel.namelabel".localized )
    private lazy var surnameLabel = ProfileLabel(label: "ProfileEditScreenLabel.surname".localized)
    private lazy var cityLabel = ProfileLabel(label: "ProfileEditScreenLabel.cityLabel".localized )
    private lazy var emailLabel = ProfileLabel(label: "ProfileEditScreenLabel.emailLabel".localized)
    private lazy var phoneLabel = ProfileLabel(label: "ProfileEditScreenLabel.telephoneLabel".localized)
    private lazy var dateOfBirthLabel = ProfileLabel(label: "ProfileEditScreenLabel.dateOfBirthLabel".localized )
    
    private lazy var showButton: UIButton = {
        let showButton = UIButton()
        showButton.layer.borderColor = UIColor.customDarkBlue.cgColor
        showButton.layer.cornerRadius = 30
        showButton.tintColor = .customDarkBlue
        showButton.backgroundColor = .gray
        showButton.setTitle("ProfileEditScreen.showButton".localized, for: .normal)
        showButton.addTarget(self, action: #selector(showButtonTapped), for: .touchUpInside)
        return showButton
    }()
    
    //MARK: - Life Cycle
    
    init(profile: Profile) {
        self.profile = profile
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        photoEdit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: - Private Mehtods
    
    private func photoEdit() {
        photoEditImageView.image = UIImage(named: "photoEdit")
        photoEditImageView.alpha = 1
        photoEditImageView.tintColor = .black
        photoEditImageView.layer.cornerRadius = 60
        photoEditImageView.clipsToBounds = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnPhotoEdit))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        photoEditImageView.isUserInteractionEnabled = true
        photoEditImageView.addGestureRecognizer(tapGesture)
    }
    
    private func setupUI() {
        setCustomBackBarItem(title:"ProfileEditScreen.navBar".localized)

        view.layer.cornerRadius = LayoutConstants.cornerRadius
        view.backgroundColor = .customOrange
        viewList.addSubviews(nameField, nameLabel,surnameField, surnameLabel, cityField, cityLabel, emailField, emailLabel, phoneField,
                             phoneLabel, dateOfBirthField, dateOfBirthLabel)
        view.addSubviews(viewBackground, photoEditImageView, viewList, showButton)
        NSLayoutConstraint.activate([
            viewBackground.topAnchor.constraint(equalTo: view.topAnchor),
            viewBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewBackground.heightAnchor.constraint(equalToConstant: SizeEditScreen.backgroundHeight),
            
            photoEditImageView.topAnchor.constraint(equalTo: view.topAnchor,
                                                    constant: SizeEditScreen.imageTopOffset),
            photoEditImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            photoEditImageView.heightAnchor.constraint(equalToConstant: SizeEditScreen.photoImage),
            photoEditImageView.widthAnchor.constraint(equalToConstant: SizeEditScreen.photoImage),
            
            viewList.topAnchor.constraint(equalTo: viewBackground.bottomAnchor,
                                          constant: LayoutConstants.defaultOffSet),
            viewList.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                              constant: LayoutConstants.indentSixteen),
            viewList.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                               constant: -LayoutConstants.indentSixteen),
            nameField.topAnchor.constraint(equalTo: viewList.topAnchor,
                                           constant: SizeEditScreen.verticalOffset),
            nameField.leadingAnchor.constraint(equalTo: viewList.leadingAnchor,
                                               constant: LayoutConstants.defaultOffSet),
            nameField.trailingAnchor.constraint(equalTo: viewList.trailingAnchor,
                                                constant: -LayoutConstants.defaultOffSet),
            nameField.heightAnchor.constraint(equalToConstant: SizeEditScreen.fieldHeight),
            nameField.widthAnchor.constraint(equalToConstant: SizeEditScreen.fieldWidth),
            nameField.bottomAnchor.constraint(equalTo: surnameField.topAnchor,
                                              constant: -LayoutConstants.defaultOffSet),
            
            nameLabel.topAnchor.constraint(equalTo: viewList.topAnchor, 
                                           constant: LayoutConstants.indentSixteen),
            nameLabel.leadingAnchor.constraint(equalTo: viewList.leadingAnchor, 
                                               constant: SizeEditScreen.labelLeading),
            nameLabel.heightAnchor.constraint(equalToConstant: LayoutConstants.defaultOffSet),
            nameLabel.widthAnchor.constraint(equalToConstant: nameLabel.frame.width),
            
            surnameField.topAnchor.constraint(equalTo: nameField.bottomAnchor,
                                              constant: LayoutConstants.defaultOffSet),
            surnameField.leadingAnchor.constraint(equalTo: viewList.leadingAnchor,
                                                  constant: LayoutConstants.defaultOffSet),
            surnameField.trailingAnchor.constraint(equalTo: viewList.trailingAnchor,
                                                   constant: -LayoutConstants.defaultOffSet),
            surnameField.heightAnchor.constraint(equalToConstant: SizeEditScreen.fieldHeight),
            surnameField.widthAnchor.constraint(equalToConstant: SizeEditScreen.fieldWidth),
            surnameField.bottomAnchor.constraint(equalTo: cityField.topAnchor,
                                                 constant: -LayoutConstants.defaultOffSet),
            
            surnameLabel.topAnchor.constraint(equalTo: nameField.bottomAnchor,
                                           constant: LayoutConstants.indentEight),
            surnameLabel.leadingAnchor.constraint(equalTo: viewList.leadingAnchor,
                                               constant: SizeEditScreen.labelLeading),
            surnameLabel.heightAnchor.constraint(equalToConstant: LayoutConstants.defaultOffSet),
            surnameLabel.widthAnchor.constraint(equalToConstant: surnameLabel.frame.width),
            
            cityField.topAnchor.constraint(equalTo: surnameField.bottomAnchor,
                                           constant: LayoutConstants.defaultOffSet),
            cityField.leadingAnchor.constraint(equalTo: viewList.leadingAnchor,
                                               constant: LayoutConstants.defaultOffSet),
            cityField.trailingAnchor.constraint(equalTo: viewList.trailingAnchor,
                                                constant: -LayoutConstants.defaultOffSet),
            cityField.bottomAnchor.constraint(equalTo: emailField.topAnchor,
                                              constant: -LayoutConstants.defaultOffSet),
            cityField.heightAnchor.constraint(equalToConstant: SizeEditScreen.fieldHeight),
            cityField.widthAnchor.constraint(equalToConstant: SizeEditScreen.fieldWidth),
            
            cityLabel.topAnchor.constraint(equalTo: surnameField.bottomAnchor,
                                           constant: LayoutConstants.indentEight),
            cityLabel.leadingAnchor.constraint(equalTo: viewList.leadingAnchor,
                                               constant: SizeEditScreen.labelLeading),
            cityLabel.heightAnchor.constraint(equalToConstant: LayoutConstants.defaultOffSet),
            cityLabel.widthAnchor.constraint(equalToConstant: cityLabel.frame.width),
            emailField.topAnchor.constraint(equalTo: cityField.bottomAnchor,
                                            constant: LayoutConstants.defaultOffSet),
            emailField.leadingAnchor.constraint(equalTo: viewList.leadingAnchor,
                                                constant: LayoutConstants.defaultOffSet),
            emailField.trailingAnchor.constraint(equalTo: viewList.trailingAnchor,
                                                 constant: -LayoutConstants.defaultOffSet),
            emailField.bottomAnchor.constraint(equalTo: phoneField.topAnchor,
                                               constant: -LayoutConstants.defaultOffSet),
            emailField.heightAnchor.constraint(equalToConstant: SizeEditScreen.fieldHeight),
            emailField.widthAnchor.constraint(equalToConstant: SizeEditScreen.fieldWidth),
            
            emailLabel.topAnchor.constraint(equalTo: cityField.bottomAnchor, 
                                            constant: LayoutConstants.indentTen),
            emailLabel.leadingAnchor.constraint(equalTo: viewList.leadingAnchor, 
                                                constant: SizeEditScreen.labelLeading),
            emailLabel.heightAnchor.constraint(equalToConstant: LayoutConstants.defaultOffSet),
            emailLabel.widthAnchor.constraint(equalToConstant: emailLabel.frame.width),
            phoneField.topAnchor.constraint(equalTo: emailField.bottomAnchor,
                                            constant: LayoutConstants.defaultOffSet),
            phoneField.leadingAnchor.constraint(equalTo: viewList.leadingAnchor,
                                                constant: LayoutConstants.defaultOffSet),
            phoneField.trailingAnchor.constraint(equalTo: viewList.trailingAnchor,
                                                 constant: -LayoutConstants.defaultOffSet),
            phoneField.bottomAnchor.constraint(equalTo: dateOfBirthField.topAnchor,
                                               constant: -LayoutConstants.defaultOffSet),
            phoneField.heightAnchor.constraint(equalToConstant: SizeEditScreen.fieldHeight),
            phoneField.widthAnchor.constraint(equalToConstant: SizeEditScreen.fieldWidth),
            
            phoneLabel.topAnchor.constraint(equalTo: emailField.bottomAnchor, 
                                            constant: LayoutConstants.indentTen),
            phoneLabel.leadingAnchor.constraint(equalTo: viewList.leadingAnchor, 
                                                constant: SizeEditScreen.labelLeading),
            phoneLabel.heightAnchor.constraint(equalToConstant: LayoutConstants.defaultOffSet),
            phoneLabel.widthAnchor.constraint(equalToConstant: phoneLabel.frame.width),
            dateOfBirthField.topAnchor.constraint(equalTo: phoneField.bottomAnchor,
                                                  constant: LayoutConstants.defaultOffSet),
            dateOfBirthField.leadingAnchor.constraint(equalTo: viewList.leadingAnchor,
                                                      constant: LayoutConstants.defaultOffSet),
            dateOfBirthField.trailingAnchor.constraint(equalTo: viewList.trailingAnchor,
                                                       constant: -LayoutConstants.defaultOffSet),
            dateOfBirthField.heightAnchor.constraint(equalToConstant: SizeEditScreen.fieldHeight),
            dateOfBirthField.widthAnchor.constraint(equalToConstant: SizeEditScreen.fieldWidth),
            dateOfBirthField.bottomAnchor.constraint(equalTo: viewList.bottomAnchor,
                                                     constant: -SizeEditScreen.verticalOffset),
            dateOfBirthLabel.topAnchor.constraint(equalTo: phoneField.bottomAnchor,
                                                  constant: LayoutConstants.indentTen),
            dateOfBirthLabel.leadingAnchor.constraint(equalTo: viewList.leadingAnchor, 
                                                      constant: SizeEditScreen.labelLeading),
            dateOfBirthLabel.heightAnchor.constraint(equalToConstant: LayoutConstants.defaultOffSet),
            dateOfBirthLabel.widthAnchor.constraint(equalToConstant: dateOfBirthLabel.frame.width),
            showButton.topAnchor.constraint(equalTo: viewList.bottomAnchor,
                                            constant: SizeEditScreen.buttonTopOffset),
            showButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                constant: LayoutConstants.defaultOffSet),
            showButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                 constant: -LayoutConstants.defaultOffSet),
            showButton.heightAnchor.constraint(equalToConstant: SizeEditScreen.buttonHeight),
            showButton.widthAnchor.constraint(equalToConstant: SizeEditScreen.buttonWidth)
        ])
    }
    
    private func setupPicker() {
        ImagePicker.shared.showPicker(controller: self, selectionLimit: 1) { [weak self] image in
            DispatchQueue.main.async {
                self?.photoEditImageView.image = image
            }
        }
    }
    
    //MARK: - Event Handler
    
    @objc func didTapOnPhotoEdit() {
        print("tapped on photo edit must be alert")
        Alert.shared.photoEditAlert(viewController: self) {
            self.setupPicker()
        }
    }
    @objc func showButtonTapped() {
        print("save button must save user info")
    }
}
