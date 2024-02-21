//
//  ProfileEditScreenController.swift
//  mams.paps
//
//  Created by Юлия Кагирова on 29.01.2024.
//

import UIKit
import PhotosUI

//dateofbirth ????

enum SizeEditScreen {
    ///28
    static let twentyEight: CGFloat = 28
    ///30
    static let thirty: CGFloat = 30
    ///40
    static let fourty: CGFloat = 40
    ///41
    static let fourtyOne: CGFloat = 41
    ///43
    static let fourtyThree: CGFloat = 43
    ///48
    static let fourtyEight: CGFloat = 48
    ///57
    static let fiftySeven: CGFloat = 57
    ///60
    static let sixty: CGFloat = 60
    ///65
    static let sixtyFive: CGFloat = 65
    ///96
    static let nintySix: CGFloat = 96
    ///100
    static let oneH: CGFloat = 100
    ///108
    static let oneHeight: CGFloat = 108
    ///120
    static let oneHtwenty: CGFloat = 120
    ///135
    static let oneHthirtyFive: CGFloat = 135
    ///245
    static let twoHfourtyFive: CGFloat = 245
    ///318
    static let threeHeighteen: CGFloat = 318
    ///350
    static let threeHfifty: CGFloat = 350
}

final class ProfileEditScreenController: UIViewController {
    
    //MARK: - Private Properties
    
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
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .label
        return imageView
    }()
    private lazy var nameText = "ProfileEditScreen.nameText".localized
    private lazy var cityText =  "ProfileEditScreen.cityText".localized
    private lazy var emailText = "ProfileEditScreen.emailText".localized
    private lazy var phoneText =  "ProfileEditScreen.phoneText".localized
    private lazy var dateOfBirthText =  "ProfileEditScreen.dateOfBirthText".localized
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
        nameField.attributedPlaceholder = NSAttributedString.init(string: "Владимир", attributes: [NSAttributedString.Key.foregroundColor: UIColor.customGreyButtons])
        nameField.addTarget(self, action: #selector(nameTextChanged), for: .editingChanged)
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        nameField.leftView = paddingView
        return nameField
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = " " + "Ваше Имя"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .customDarkBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        label.contentMode = .scaleAspectFit
        label.clipsToBounds = true
        return label
    }()
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
        cityField.attributedPlaceholder = NSAttributedString.init(string: "Москва", attributes: [NSAttributedString.Key.foregroundColor: UIColor.customGreyButtons])
        cityField.addTarget(self, action: #selector(cityTextChanged), for: .editingChanged)
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        cityField.leftView = paddingView
        return cityField
    }()
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = " " + "Город"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .customDarkBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        label.contentMode = .scaleAspectFit
        label.clipsToBounds = true
        return label
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
        emailField.attributedPlaceholder = NSAttributedString.init(string: "mail@gmail.com", attributes: [NSAttributedString.Key.foregroundColor: UIColor.customGreyButtons])
        emailField.addTarget(self, action: #selector(emailTextChanged), for: .editingChanged)
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        emailField.leftView = paddingView
        return emailField
    }()
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = " " + "Почта"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .customDarkBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        label.contentMode = .scaleAspectFit
        label.clipsToBounds = true
        return label
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
        phoneField.attributedPlaceholder = NSAttributedString.init(string: "+7 (XXX) XXX-XX-XX", attributes: [NSAttributedString.Key.foregroundColor: UIColor.customGreyButtons])
        phoneField.addTarget(self, action: #selector(phoneTextChanged), for: .editingChanged)
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        phoneField.leftView = paddingView
        return phoneField
    }()
    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = " " + "Телефон"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .customDarkBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        label.contentMode = .scaleAspectFit
        label.clipsToBounds = true
        return label
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
        dateOfBirthField.attributedPlaceholder = NSAttributedString.init(string: "XX/XX/XXXX", attributes: [NSAttributedString.Key.foregroundColor: UIColor.customGreyButtons])
        dateOfBirthField.addTarget(self, action: #selector(dateOfBirthTextChanged), for: .editingChanged)
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        dateOfBirthField.leftView = paddingView
        return dateOfBirthField
    }()
    private lazy var dateOfBirthLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = " " + "Дата рождения"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .customDarkBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        label.contentMode = .scaleAspectFit
        label.clipsToBounds = true
        return label
    }()
    private lazy var showButton: UIButton = {
        let showButton = UIButton()
        showButton.layer.borderColor = UIColor.customDarkBlue.cgColor
        showButton.layer.cornerRadius = 30
        showButton.tintColor = .customDarkBlue
        showButton.backgroundColor = .gray
        showButton.setTitle("Показать", for: .normal)
        showButton.addTarget(self, action: #selector(showButtonTapped), for: .touchUpInside)
        return showButton
    }()
    
    //MARK: - Life Cycle
    
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
        
        // add a tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnPhotoEdit))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        photoEditImageView.isUserInteractionEnabled = true
        photoEditImageView.addGestureRecognizer(tapGesture)
    }
    
    private func setupUI() {
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(
            title: "Редактирование профиля",
            style: .done,
            target: self,
            action: nil)
        navigationController?.navigationBar.tintColor = .customGrey
        
        view.layer.cornerRadius = LayoutConstants.cornerRadius
        view.backgroundColor = .customOrange
        viewList.addSubviews(
            nameField, nameLabel, cityField, cityLabel, emailField, emailLabel, phoneField, phoneLabel,
            dateOfBirthField, dateOfBirthLabel)
        view.addSubviews(viewBackground, photoEditImageView, viewList, showButton)
        NSLayoutConstraint.activate([
            viewBackground.topAnchor.constraint(equalTo: view.topAnchor),
            viewBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewBackground.heightAnchor.constraint(equalToConstant: SizeEditScreen.twoHfourtyFive),
            
            photoEditImageView.topAnchor.constraint(equalTo: view.topAnchor, 
                                                    constant: SizeEditScreen.oneH),
            photoEditImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                        constant: SizeEditScreen.oneHthirtyFive),
            photoEditImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, 
                                                         constant: -SizeEditScreen.oneHthirtyFive),
            photoEditImageView.heightAnchor.constraint(equalToConstant: SizeEditScreen.oneHtwenty),
            photoEditImageView.widthAnchor.constraint(equalToConstant: SizeEditScreen.oneHtwenty),
            
            viewList.topAnchor.constraint(equalTo: viewBackground.bottomAnchor,
                                          constant: LayoutConstants.defaultOffSet),
            viewList.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                              constant: LayoutConstants.indentSixteen),
            viewList.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                               constant: -LayoutConstants.indentSixteen),
            viewList.bottomAnchor.constraint(equalTo: dateOfBirthField.bottomAnchor,
                                             constant: SizeEditScreen.twentyEight),
            
            nameField.topAnchor.constraint(equalTo: viewList.topAnchor,
                                           constant: SizeEditScreen.twentyEight),
            nameField.leadingAnchor.constraint(equalTo: viewList.leadingAnchor,
                                               constant: LayoutConstants.defaultOffSet),
            nameField.trailingAnchor.constraint(equalTo: viewList.trailingAnchor,
                                                constant: -LayoutConstants.defaultOffSet),
            nameField.heightAnchor.constraint(equalToConstant: SizeEditScreen.fourtyEight),
            nameField.widthAnchor.constraint(equalToConstant: SizeEditScreen.threeHeighteen),
            nameField.bottomAnchor.constraint(equalTo: cityField.topAnchor,
                                              constant: -LayoutConstants.defaultOffSet),
            
            nameLabel.topAnchor.constraint(equalTo: viewList.topAnchor, 
                                           constant: LayoutConstants.indentSixteen),
            nameLabel.leadingAnchor.constraint(equalTo: viewList.leadingAnchor, 
                                               constant: SizeEditScreen.thirty),
            nameLabel.heightAnchor.constraint(equalToConstant: LayoutConstants.defaultOffSet),
            nameLabel.widthAnchor.constraint(equalToConstant: SizeEditScreen.sixtyFive),
            
            cityField.topAnchor.constraint(equalTo: nameField.bottomAnchor,
                                           constant: LayoutConstants.defaultOffSet),
            cityField.leadingAnchor.constraint(equalTo: viewList.leadingAnchor,
                                               constant: LayoutConstants.defaultOffSet),
            cityField.trailingAnchor.constraint(equalTo: viewList.trailingAnchor,
                                                constant: -LayoutConstants.defaultOffSet),
            cityField.bottomAnchor.constraint(equalTo: emailField.topAnchor,
                                              constant: -LayoutConstants.defaultOffSet),
            cityField.heightAnchor.constraint(equalToConstant: SizeEditScreen.fourtyEight),
            cityField.widthAnchor.constraint(equalToConstant: SizeEditScreen.threeHeighteen),
            
            cityLabel.topAnchor.constraint(equalTo: nameField.bottomAnchor, 
                                           constant: LayoutConstants.indentEight),
            cityLabel.leadingAnchor.constraint(equalTo: viewList.leadingAnchor,
                                               constant: SizeEditScreen.thirty),
            cityLabel.heightAnchor.constraint(equalToConstant: LayoutConstants.defaultOffSet),
            cityLabel.widthAnchor.constraint(equalToConstant: SizeEditScreen.fourtyOne),
            
            emailField.topAnchor.constraint(equalTo: cityField.bottomAnchor,
                                            constant: LayoutConstants.defaultOffSet),
            emailField.leadingAnchor.constraint(equalTo: viewList.leadingAnchor,
                                                constant: LayoutConstants.defaultOffSet),
            emailField.trailingAnchor.constraint(equalTo: viewList.trailingAnchor,
                                                 constant: -LayoutConstants.defaultOffSet),
            emailField.bottomAnchor.constraint(equalTo: phoneField.topAnchor,
                                               constant: -LayoutConstants.defaultOffSet),
            emailField.heightAnchor.constraint(equalToConstant: SizeEditScreen.fourtyEight),
            emailField.widthAnchor.constraint(equalToConstant: SizeEditScreen.threeHeighteen),
            
            emailLabel.topAnchor.constraint(equalTo: cityField.bottomAnchor, 
                                            constant: LayoutConstants.indentTen),
            emailLabel.leadingAnchor.constraint(equalTo: viewList.leadingAnchor,
                                                constant: SizeEditScreen.thirty),
            emailLabel.heightAnchor.constraint(equalToConstant: LayoutConstants.defaultOffSet),
            emailLabel.widthAnchor.constraint(equalToConstant: SizeEditScreen.fourtyThree),
            
            phoneField.topAnchor.constraint(equalTo: emailField.bottomAnchor,
                                            constant: LayoutConstants.defaultOffSet),
            phoneField.leadingAnchor.constraint(equalTo: viewList.leadingAnchor,
                                                constant: LayoutConstants.defaultOffSet),
            phoneField.trailingAnchor.constraint(equalTo: viewList.trailingAnchor,
                                                 constant: -LayoutConstants.defaultOffSet),
            phoneField.bottomAnchor.constraint(equalTo: dateOfBirthField.topAnchor,
                                               constant: -LayoutConstants.defaultOffSet),
            phoneField.heightAnchor.constraint(equalToConstant: SizeEditScreen.fourtyEight),
            phoneField.widthAnchor.constraint(equalToConstant: SizeEditScreen.threeHeighteen),
            
            phoneLabel.topAnchor.constraint(equalTo: emailField.bottomAnchor,
                                            constant: LayoutConstants.indentTen),
            phoneLabel.leadingAnchor.constraint(equalTo: viewList.leadingAnchor, 
                                                constant: SizeEditScreen.thirty),
            phoneLabel.heightAnchor.constraint(equalToConstant: LayoutConstants.defaultOffSet),
            phoneLabel.widthAnchor.constraint(equalToConstant: SizeEditScreen.fiftySeven),
            
            dateOfBirthField.topAnchor.constraint(equalTo: phoneField.bottomAnchor,
                                                  constant: LayoutConstants.defaultOffSet),
            dateOfBirthField.leadingAnchor.constraint(equalTo: viewList.leadingAnchor,
                                                      constant: LayoutConstants.defaultOffSet),
            dateOfBirthField.trailingAnchor.constraint(equalTo: viewList.trailingAnchor,
                                                       constant: -LayoutConstants.defaultOffSet),
            dateOfBirthField.heightAnchor.constraint(equalToConstant: SizeEditScreen.fourtyEight),
            dateOfBirthField.widthAnchor.constraint(equalToConstant: SizeEditScreen.threeHeighteen),
            dateOfBirthLabel.topAnchor.constraint(equalTo: phoneField.bottomAnchor,
                                                  constant: LayoutConstants.indentTen),
            dateOfBirthLabel.leadingAnchor.constraint(equalTo: viewList.leadingAnchor, 
                                                      constant: SizeEditScreen.thirty),
            
            dateOfBirthLabel.heightAnchor.constraint(equalToConstant: LayoutConstants.defaultOffSet),
            dateOfBirthLabel.widthAnchor.constraint(equalToConstant: SizeEditScreen.nintySix),
            
            showButton.topAnchor.constraint(equalTo: viewList.bottomAnchor,
                                            constant: SizeEditScreen.fourty),
            showButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                constant: LayoutConstants.defaultOffSet),
            showButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                 constant: -LayoutConstants.defaultOffSet),
            showButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                               constant: -SizeEditScreen.oneHeight),
            showButton.heightAnchor.constraint(equalToConstant: SizeEditScreen.sixty),
            showButton.widthAnchor.constraint(equalToConstant: SizeEditScreen.threeHfifty)
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
    @objc private func nameTextChanged(_ textField: UITextField) {
        nameText = textField.text ?? ""
    }
    @objc private func cityTextChanged(_ textField: UITextField) {
        cityText = textField.text ?? ""
    }
    @objc private func emailTextChanged(_ textField: UITextField) {
        emailText = textField.text ?? ""
    }
    @objc private func phoneTextChanged(_ textField: UITextField) {
        phoneText = textField.text ?? ""
    }
    @objc private func dateOfBirthTextChanged(_ textField: UITextField) {
        dateOfBirthText = textField.text ?? ""
    }
}
