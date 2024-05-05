

import UIKit

final class PopupViewController: UIViewController {
    
    // MARK: - Private properties
    private let callback: ((Int) -> Void)?
    private let popupView = PopupView()
    
    // MARK: - Life Cycle
    init(callback: ((Int) -> Void)?) {
        self.callback = callback
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPopupView()
    }
    
    // MARK: - Private methods
    private func setupPopupView() {
        popupView.delegate = self
        view.addSubviews(popupView, translatesAutoresizingMaskIntoConstraints: false)
        
        NSLayoutConstraint.activate([
            popupView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 631/390),
            popupView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            popupView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            popupView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

// MARK: - PopupViewProtocol
extension PopupViewController: PopupViewProtocol {
    func filterDidTap(with itemIndex: Int) {
        dismiss(animated: true) { [weak self] in
            guard let self else { return }
            callback?(itemIndex)
        }
    }
}
