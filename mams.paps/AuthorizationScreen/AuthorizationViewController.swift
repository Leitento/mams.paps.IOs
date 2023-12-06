

import UIKit

final class AuthorizationViewController: UIViewController {
    
    // MARK: - Private properties
    private var viewModel: AuthorizationViewModelProtocol
    private var authorizationView: AuthorizationView
    private var keyboardObserver: NSObjectProtocol?
    
    // MARK: - Life Cycle
    init(viewModel: AuthorizationViewModelProtocol) {
        self.viewModel = viewModel
        self.authorizationView = AuthorizationView()
        super.init(nibName: nil, bundle: nil)
        authorizationView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAuthorizationView()
        bindingViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
    }
    
    // MARK: - Private methods
    private func setupAuthorizationView() {
        view = authorizationView
        navigationController?.navigationBar.isHidden = true
    }
    
    private func bindingViewModel() {
        viewModel.stateChanger = { [weak self] state in
            guard let self else { return }
            switch state {
            case .withoutLogin:
                viewModel.showMainScreenForGuest()
            case .errorLogin(let error):
                Alert.shared.showAlert(on: self, title: "AlertTitle.Error".localized, message: error)
            case .loginSuccess(let user):
                viewModel.showMainScreenForUser(for: user)
            }
        }
    }
    
    private func setupKeyboardObservers() {
        keyboardObserver = NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillChangeFrameNotification,
            object: nil,
            queue: .main
        ) { [weak self] notification in
            self?.keyboardFrameWillChange(notification)
        }
        
        NotificationCenter.default.addObserver(
                   forName: UIResponder.keyboardWillHideNotification,
                   object: nil,
                   queue: .main
        ) { [weak self] notification in
            self?.keyboardWillHide(notification)
        }
    }
    
    private func removeKeyboardObservers() {
        if let observer = keyboardObserver {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    private func keyboardFrameWillChange(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let keyboardFrameEnd = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let window = view.window
        else {
            return
        }
        
        let keyboardFrameEndInWindow = window.convert(keyboardFrameEnd, from: nil)
        let intersection = authorizationView.scrollView.frame.intersection(keyboardFrameEndInWindow)
        
        if intersection.isNull {
            authorizationView.scrollView.contentInset.bottom = 0
        } else {
            authorizationView.scrollView.contentInset.bottom = intersection.height + 5
            authorizationView.scrollView.scrollToBottom(animated: true)
        }
        
        authorizationView.scrollView.scrollIndicatorInsets = authorizationView.scrollView.contentInset
    }
    
    private func keyboardWillHide(_ notification: Notification) {
        authorizationView.scrollView.contentInset.bottom = 0
        authorizationView.scrollView.scrollToTop(animated: true)
        authorizationView.scrollView.scrollIndicatorInsets = authorizationView.scrollView.contentInset
    }
}

    // MARK: - AuthViewDelegate
extension AuthorizationViewController: AuthorizationViewDelegate {

    func forgotPasswordButtonDidTap() {
        viewModel.presentRestorePasswordController()
    }
    
    func signUpButtonDidTap() {
        viewModel.presentSignUpController()
    }
    
    func continueWithoutRegistrationButtonDidTap() {
        viewModel.showMainScreenForGuest()
    }
    
    func loginButtonDidTap(login: String, password: String) {
        viewModel.authenticateUser(login: login, password: password)
    }
}

    // MARK: - UIScrollView extension
extension UIScrollView {
    func scrollToBottom(animated: Bool) {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        setContentOffset(bottomOffset, animated: animated)
    }
    
    func scrollToTop(animated: Bool) {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: animated)
    }
}
