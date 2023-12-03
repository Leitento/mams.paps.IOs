

import UIKit

final class AuthorizationViewController: UIViewController {
    
    private var keyboardObserver: NSObjectProtocol?
    private var authorizationView: AuthorizationView
    
    
    init() {
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
    }
    
    private func setupAuthorizationView() {
        view = authorizationView
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupKeyboardObservers() {
        keyboardObserver = NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillChangeFrameNotification,
            object: nil,
            queue: .main
        ) { [weak self] notification in
            self?.keyboardFrameWillChange(notification)
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
        }
        
        authorizationView.scrollView.scrollIndicatorInsets = authorizationView.scrollView.contentInset
    }
}

extension AuthorizationViewController: AuthorizationViewDelegate {
    func forgotPasswordButtonDidTap() {
        print("forgotPasswordButtonDidTap")
    }
    
    func signUpButtonDidTap() {
        print("signUpButtonDidTap")
    }
    
    func continueWithoutRegistrationButtonDidTap() {
        print("continueWithoutRegistrationButtonDidTap")
    }
    
    func loginButtonDidTap() {
        print("loginButtonDidTap")
    }
    
    
}
