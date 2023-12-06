

import UIKit

protocol AuthorizationViewDelegate: AnyObject {
    func forgotPasswordButtonDidTap()
    func signUpButtonDidTap()
    func continueWithoutRegistrationButtonDidTap()
    func loginButtonDidTap(login: String, password: String)
}

final class AuthorizationView: UIView {
    
    private enum Constants {
        static let aspectRatioMultiplier: CGFloat = 325 / 390
        static let padding: CGFloat = 20
        static let textFieldHeight: CGFloat = 52
        static let customButtonHeight: CGFloat = 50
        static let labelButtonHeight: CGFloat = 21
    }
    
    weak var delegate: AuthorizationViewDelegate?
    
    // MARK: - Private properties
    private(set) lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .systemOrange

        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var topView: UIView = {
        let topView = RoundedBottomView()
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.backgroundColor = .white
        topView.addSubview(imageView)
        topView.addSubview(welcomeLabel)
        return topView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "authorizationScreen"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var welcomeLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = .systemFont(ofSize: 28, weight: .semibold)
        textLabel.textColor = .black
        textLabel.textAlignment = .center
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.numberOfLines = 2
        textLabel.text = "Authorization.welcome".localized
        return textLabel
    }()
    
    private lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = .systemFont(ofSize: 16, weight: .regular)
        textLabel.textColor = .black
        textLabel.textAlignment = .left
        textLabel.numberOfLines = 2
        textLabel.text = "Authorization.info".localized
        return textLabel
    }()
    
    private lazy var loginField: UITextField = {
        let textField = AuthTextField(placeholder: "Login.placeholder".localized, fontSize: 16, icon: UIImage(systemName: "envelope"))
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    private lazy var passwordField: UITextField = {
        let textField = AuthTextField(placeholder: "Password.placeholder".localized, fontSize: 16, icon: UIImage(systemName: "lock"))
        textField.isSecureTextEntry = true
        textField.textContentType = .password
        return textField
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let forgotPasswordButton = UIButton(type: .system)
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordButton.setTitle("RestorePassword.text".localized, for: .normal)
        forgotPasswordButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        forgotPasswordButton.setTitleColor(.systemBlue, for: .normal)
        forgotPasswordButton.sizeToFit()
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonTapped(_:)), for: .touchUpInside)
        return forgotPasswordButton
    }()
    
    private lazy var signUpButton: UIButton = {
        let signUpButton = UIButton(type: .system)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.setTitle("SignUp.text".localized, for: .normal)
        signUpButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        signUpButton.setTitleColor(.systemBlue, for: .normal)
        signUpButton.sizeToFit()
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped(_:)), for: .touchUpInside)
        return signUpButton
    }()
    
    private lazy var continueButton: UIButton = {
        let continueButton = UIButton(type: .system)
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButton.setTitle("ContinueButton.text".localized, for: .normal)
        continueButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
        continueButton.backgroundColor = .clear
        continueButton.layer.borderWidth = 2.0
        continueButton.layer.borderColor = UIColor.black.cgColor
        continueButton.layer.cornerRadius = 24
        continueButton.setTitleColor(.black, for: .normal)
        continueButton.addTarget(self, action: #selector(continueButtonTapped(_:)), for: .touchUpInside)
        return continueButton
    }()
    
    private lazy var logInButton: UIButton = {
        let logInButton = UIButton(type: .system)
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        logInButton.setTitle("logInButton.text".localized, for: .normal)
        logInButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
        logInButton.backgroundColor = .white
        logInButton.layer.cornerRadius = 24
        logInButton.setTitleColor(.black, for: .normal)
        logInButton.addTarget(self, action: #selector(logInButtonTapped(_:)), for: .touchUpInside)
        return logInButton
    }()
    
    // MARK: - Life Cycle
    init() {
        super.init(frame: .zero)
        setupView()
        addSubviews()
        setupConstraints()
        setupContentOfScrollView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setupView() {
        backgroundColor = .white
    }
    
    private func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    private func setupContentOfScrollView() {

        contentView.addSubview(topView)
        contentView.addSubview(textLabel)
        contentView.addSubview(loginField)
        contentView.addSubview(passwordField)
        contentView.addSubview(forgotPasswordButton)
        contentView.addSubview(signUpButton)
        contentView.addSubview(continueButton)
        contentView.addSubview(logInButton)
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: contentView.topAnchor),
            topView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            topView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            imageView.topAnchor.constraint(equalTo: topView.topAnchor, constant: Constants.padding),
            imageView.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            imageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: topView.widthAnchor, multiplier: 0.5),
            
            welcomeLabel.topAnchor.constraint(lessThanOrEqualTo: imageView.bottomAnchor, constant: Constants.padding),
            welcomeLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            welcomeLabel.widthAnchor.constraint(equalTo: topView.widthAnchor, multiplier: 0.5),
            welcomeLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -Constants.padding),
            
            textLabel.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 14),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding),
            
            loginField.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: Constants.padding),
            loginField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight),
            loginField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding),
            loginField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding),
            
            passwordField.topAnchor.constraint(equalTo: loginField.bottomAnchor, constant: 16),
            passwordField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight),
            passwordField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding),
            passwordField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding),
            
            forgotPasswordButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 18),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: Constants.labelButtonHeight),
            forgotPasswordButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding),
            
            signUpButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 18),
            signUpButton.heightAnchor.constraint(equalToConstant: Constants.labelButtonHeight),
            signUpButton.leadingAnchor.constraint(greaterThanOrEqualTo: forgotPasswordButton.trailingAnchor, constant: 10),
            signUpButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding),
            
            continueButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 39),
            continueButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding),
            continueButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding),
            continueButton.heightAnchor.constraint(equalToConstant: Constants.customButtonHeight),
            
            logInButton.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: Constants.padding),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding),
            logInButton.heightAnchor.constraint(equalToConstant: Constants.customButtonHeight),
        ])
        logInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.padding).isActive = true
    }
    
    @objc private func forgotPasswordButtonTapped(_ sender: UIButton) {
        delegate?.forgotPasswordButtonDidTap()
    }
    
    @objc private func signUpButtonTapped(_ sender: UIButton) {
        delegate?.signUpButtonDidTap()
    }
    
    @objc private func continueButtonTapped(_ sender: UIButton) {
        delegate?.continueWithoutRegistrationButtonDidTap()
    }
    
    @objc private func logInButtonTapped(_ sender: UIButton) {
        guard let login = loginField.text, let password = passwordField.text else {
            return
        }
        delegate?.loginButtonDidTap(login: login, password: password)
    }
}


