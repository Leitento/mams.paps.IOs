//
//  ProfileEditScreenController.swift
//  mams.paps
//
//  Created by Юлия Кагирова on 29.01.2024.
//

import UIKit

class ProfileEditScreenController: UIViewController {
    
    //MARK: - Properties
        
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

    private lazy var nameField: UITextField = {
        let nameField = UITextField()
        nameField.layer.borderColor = UIColor.customDarkBlue.cgColor
        nameField.layer.borderWidth = 2
        nameField.keyboardType = .emailAddress
        nameField.font = UIFont.systemFont(ofSize: 16)
        nameField.autocapitalizationType = .none
        nameField.clearButtonMode = UITextField.ViewMode.whileEditing
        nameField.returnKeyType = .done
        nameField.layer.cornerRadius = LayoutConstants.cornerRadius
        nameField.textAlignment = .left
        nameField.leftViewMode = .always
        nameField.textColor = .customGreyButtons
        nameField.backgroundColor = .white
        nameField.attributedPlaceholder = NSAttributedString.init(string: "Ваше Имя...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.customDarkBlue])
        nameField.addTarget(self, action: #selector(nameTextChanged), for: .editingChanged)
        return nameField
    }()
    
    private lazy var nameView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "nameLabel"))
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var nameText = "Владимир"
    private lazy var cityText = "Москва"
//    private lazy var emailText = "mail@mail.ru"
//    private lazy var phoneText = "+7 (900) 000-00-00"
//    private lazy var dateOfBirthText = "XX/XX/XXXX"
    
    
    private lazy var photoEditImageView = UIImageView()
    
    private lazy var cityField: UITextField = {
        let cityField = UITextField()
        cityField.layer.borderColor = UIColor.customDarkBlue.cgColor
        cityField.layer.borderWidth = 2
        cityField.keyboardType = .emailAddress
        cityField.font = UIFont.systemFont(ofSize: 16)
        cityField.autocapitalizationType = .none
        cityField.clearButtonMode = UITextField.ViewMode.whileEditing
        cityField.returnKeyType = .done
        cityField.layer.cornerRadius = LayoutConstants.cornerRadius
        cityField.textAlignment = .left
        cityField.leftViewMode = .always
        cityField.textColor = .customGreyButtons
        cityField.backgroundColor = .white
        cityField.attributedPlaceholder = NSAttributedString.init(string: "Город", attributes: [NSAttributedString.Key.foregroundColor: UIColor.customDarkBlue])
        cityField.addTarget(self, action: #selector(cityTextChanged), for: .editingChanged)
        return cityField
    }()
    
    private lazy var cityView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "cityLabel"))
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var emailField: UITextField = {
        let emailField = UITextField()
        emailField.layer.borderColor = UIColor.customDarkBlue.cgColor
        emailField.layer.borderWidth = 2
        emailField.keyboardType = .emailAddress
        emailField.font = UIFont.systemFont(ofSize: 16)
        emailField.autocapitalizationType = .none
        emailField.clearButtonMode = UITextField.ViewMode.whileEditing
        emailField.returnKeyType = .done
        emailField.layer.cornerRadius = LayoutConstants.cornerRadius
        emailField.textAlignment = .left
        emailField.leftViewMode = .always
        emailField.textColor = .customGreyButtons
        emailField.backgroundColor = .white
//        emailField.attributedPlaceholder = NSAttributedString.init(string: "mail@gmail.com...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.customDarkBlue])
//        emailField.addTarget(self, action: #selector(emailTextChanged), for: .editingChanged)
        return emailField
    }()
    
    private lazy var emailView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "emailLabel"))
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var phoneField: UITextField = {
        let phoneField = UITextField()
        phoneField.layer.borderColor = UIColor.customDarkBlue.cgColor
        phoneField.layer.borderWidth = 2
        phoneField.keyboardType = .numberPad
        phoneField.font = UIFont.systemFont(ofSize: 16)
        phoneField.autocapitalizationType = .none
        phoneField.clearButtonMode = UITextField.ViewMode.whileEditing
        phoneField.returnKeyType = .done
        phoneField.layer.cornerRadius = LayoutConstants.cornerRadius
        phoneField.textAlignment = .left
        phoneField.leftViewMode = .always
        phoneField.textColor = .customGreyButtons
        phoneField.backgroundColor = .white
//        phoneField.attributedPlaceholder = NSAttributedString.init(string: "+7 (XXX) XXX-XX-XX", attributes: [NSAttributedString.Key.foregroundColor: UIColor.customDarkBlue])
//        phoneField.addTarget(self, action: #selector(phoneTextChanged), for: .editingChanged)
        return phoneField
    }()
    
    private lazy var phoneView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "phoneLabel"))
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var dateOfBirthField: UITextField = {
        let dateOfBirthField = UITextField()
        dateOfBirthField.layer.borderColor = UIColor.customDarkBlue.cgColor
        dateOfBirthField.layer.borderWidth = 2
        dateOfBirthField.keyboardType = .numberPad
        dateOfBirthField.font = UIFont.systemFont(ofSize: 16)
        dateOfBirthField.autocapitalizationType = .none
        dateOfBirthField.clearButtonMode = UITextField.ViewMode.whileEditing
        dateOfBirthField.returnKeyType = .done
        dateOfBirthField.layer.cornerRadius = LayoutConstants.cornerRadius
        dateOfBirthField.textAlignment = .left
        dateOfBirthField.leftViewMode = .always
        dateOfBirthField.textColor = .customGreyButtons
        dateOfBirthField.backgroundColor = .white
//        dateOfBirthField.attributedPlaceholder = NSAttributedString.init(string: "XX/XX/XXXX", attributes: [NSAttributedString.Key.foregroundColor: UIColor.customDarkBlue])
//        dateOfBirthField.addTarget(self, action: #selector(dateOfBirthTextChanged), for: .editingChanged)
        return dateOfBirthField
    }()
    private lazy var dateOfBirthView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "dateOfBirthLabel"))
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var showButton: UIButton = { //saveButton????
        let showButton = UIButton()
        showButton.layer.borderColor = UIColor.customDarkBlue.cgColor
        showButton.layer.cornerRadius = 30
        showButton.tintColor = .customDarkBlue
        showButton.backgroundColor = .gray
        showButton.setTitle("Показать", for: .normal)  //"Сохранить" ????
        showButton.addTarget(self, action: #selector(showButtonTapped), for: .touchUpInside)
        return showButton
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        photoEdit()
        setupPaddingTextField()
    }
    
    //MARK: - Private Mehtods
   
    private func photoEdit() {
        photoEditImageView.image = UIImage(named: "photoEdit")
        photoEditImageView.alpha = 1
        photoEditImageView.tintColor = .black
        photoEditImageView.layer.cornerRadius = 60
        photoEditImageView.clipsToBounds = true
        
        // add a tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnPhotoEdit))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        photoEditImageView.isUserInteractionEnabled = true
        photoEditImageView.addGestureRecognizer(tapGesture)
        
    }
   
    private func setupPaddingTextField() {
        
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        nameField.leftView = paddingView
        cityField.leftView = paddingView
//        emailField.leftView = paddingView
//        phoneField.leftView = paddingView
//        dateOfBirthField.leftView = paddingView
    }
    
//    private func photoAlertButton() {
//        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//        
//        let addPhoto = UIAlertAction(title: "Добавить фото", style: .default) { _ in
//            print("add photo")
//        }
//        alert.addAction(addPhoto)
//        
//        let editPhoto = UIAlertAction(title: "Изменить фото", style: .default) { _ in
//            print("edit photo")
//        }
//        alert.addAction(editPhoto)
//        
//        let deletePhoto = UIAlertAction(title: "Удалить фото", style: .destructive) { _ in
//            print("delete photo")
//        }
//        alert.addAction(deletePhoto)
//        
//        let cancel = UIAlertAction(title: "Отмена", style: .cancel) { _ in
//            print("cancel")
//        }
//        alert.addAction(cancel)
//        
//        self.present(alert, animated: true, completion: nil)
//    }
    
    private func setupUI() {
        
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(
            title: "Редактирование профиля",
            style: .done,
            target: self,
            action: nil)
        navigationController?.navigationBar.tintColor = .customGreyButtons
       
        tabBarController?.tabBar.alpha = 0
            view.layer.cornerRadius = LayoutConstants.cornerRadius
            view.backgroundColor = .customOrange
        
        viewList.addSubviews(
            nameField,nameView,cityField,cityView,emailField,emailView,phoneField,phoneView,dateOfBirthField,dateOfBirthView
        )
        view.addSubviews(viewBackground, photoEditImageView, viewList, showButton)
        
        
            NSLayoutConstraint.activate([
            viewBackground.topAnchor.constraint(equalTo: view.topAnchor),
            viewBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewBackground.heightAnchor.constraint(equalToConstant: 245),
          
            photoEditImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            photoEditImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 135),
            photoEditImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -135),
            photoEditImageView.heightAnchor.constraint(equalToConstant: 120),
            photoEditImageView.widthAnchor.constraint(equalToConstant: 120),
            
            viewList.topAnchor.constraint(equalTo: viewBackground.bottomAnchor,
                                           constant: 20),
            viewList.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                               constant: LayoutConstants.indentSixteen),
            viewList.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                constant: -LayoutConstants.indentSixteen),
            viewList.bottomAnchor.constraint(equalTo: showButton.topAnchor,
                                              constant: -20),
            
            nameField.topAnchor.constraint(equalTo: viewList.topAnchor,
                                           constant: 28),
            nameField.leadingAnchor.constraint(equalTo: viewList.leadingAnchor,
                                               constant: LayoutConstants.defaultOffSet),
            nameField.trailingAnchor.constraint(equalTo: viewList.trailingAnchor,
                                                constant: -LayoutConstants.defaultOffSet),
            nameField.heightAnchor.constraint(equalToConstant: 48),
            nameField.widthAnchor.constraint(equalToConstant: 318),
            nameField.bottomAnchor.constraint(equalTo: cityField.topAnchor,
                                              constant: -LayoutConstants.defaultOffSet),
            
            nameView.topAnchor.constraint(equalTo: viewList.topAnchor, constant: 16),
//            nameView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 30),
//            nameView.heightAnchor.constraint(equalToConstant: 20),
//            nameView.widthAnchor.constraint(equalToConstant: 62),
            
            
//            cityField.topAnchor.constraint(equalTo: nameField.bottomAnchor,
//                                           constant: LayoutConstants.defaultOffSet),
//            cityField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, 
//                                               constant: LayoutConstants.defaultOffSet),
//            cityField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor,
//                                                constant: -LayoutConstants.defaultOffSet),
//            cityField.bottomAnchor.constraint(equalTo: emailField.topAnchor, 
//                                              constant: -LayoutConstants.defaultOffSet),
//            cityField.heightAnchor.constraint(equalToConstant: 48),
//            cityField.widthAnchor.constraint(equalToConstant: 318),
//            
//            cityView.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: -8),//?
//            cityView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 30),
//            cityView.heightAnchor.constraint(equalToConstant: 20),
//            cityView.widthAnchor.constraint(equalToConstant: 41),
            
//            emailField.topAnchor.constraint(equalTo: cityField.bottomAnchor,
//                                            constant: LayoutConstants.defaultOffSet),
//            emailField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, 
//                                                constant: LayoutConstants.defaultOffSet),
//            emailField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, 
//                                                 constant: -LayoutConstants.defaultOffSet),
//            emailField.bottomAnchor.constraint(equalTo: phoneField.topAnchor,
//                                               constant: -LayoutConstants.defaultOffSet),
//            emailField.heightAnchor.constraint(equalToConstant: 48),
//            emailField.widthAnchor.constraint(equalToConstant: 318),
//            
//            phoneField.topAnchor.constraint(equalTo: emailField.bottomAnchor, 
//                                            constant: LayoutConstants.defaultOffSet),
//            phoneField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor,
//                                                constant: LayoutConstants.defaultOffSet),
//            phoneField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor,
//                                                 constant: -LayoutConstants.defaultOffSet),
//            phoneField.bottomAnchor.constraint(equalTo: dateOfBirthField.topAnchor, 
//                                               constant: -LayoutConstants.defaultOffSet),
//            phoneField.heightAnchor.constraint(equalToConstant: 48),
//            phoneField.widthAnchor.constraint(equalToConstant: 318),
//            
//            dateOfBirthField.topAnchor.constraint(equalTo: phoneField.bottomAnchor, 
//                                                  constant: LayoutConstants.defaultOffSet),
//            dateOfBirthField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor,
//                                                      constant: LayoutConstants.defaultOffSet),
//            dateOfBirthField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, 
//                                                       constant: -LayoutConstants.defaultOffSet),
//            dateOfBirthField.heightAnchor.constraint(equalToConstant: 48),
//            dateOfBirthField.widthAnchor.constraint(equalToConstant: 318),
//            dateOfBirthField.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, 
//                                                     constant: -28),
//            
            showButton.topAnchor.constraint(equalTo: viewList.bottomAnchor,
                                            constant: 40),
            showButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, 
                                                constant: LayoutConstants.defaultOffSet),
            showButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, 
                                                 constant: -LayoutConstants.defaultOffSet),
            showButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                               constant: -108),
            showButton.heightAnchor.constraint(equalToConstant: 60),
            showButton.widthAnchor.constraint(equalToConstant: 350)
        ])
    }
    //MARK: - Event Handler
    
    @objc func didTapOnPhotoEdit() {
        print("tapped on photo edit must be alert")
        Alert().showAlertAction(on: ProfileEditScreenController.init(), title: "hi", message: "jo")

    }
    @objc func showButtonTapped() {
        //save button must save user info
        print("save button must save user info")
    }
    @objc private func nameTextChanged(_ textField: UITextField) {
        nameText = textField.text ?? ""
    }
    @objc private func cityTextChanged(_ textField: UITextField) {
        cityText = textField.text ?? ""
    }
//    @objc private func emailTextChanged(_ textField: UITextField) {
//        emailText = textField.text ?? ""
//    }
//    @objc private func phoneTextChanged(_ textField: UITextField) {
//        phoneText = textField.text ?? ""
//    }
//    @objc private func dateOfBirthTextChanged(_ textField: UITextField) {
//        dateOfBirthText = textField.text ?? ""
//    }
}
