

import UIKit

final class PopupViewController: UIViewController {
    
    // MARK: - Private properties
    private let callback: (() -> Void)?
    private let popupView = PopupView()
    
    // MARK: - Life Cycle
    init(callback: (() -> Void)?) {
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
    func firstCellDidTap() {
        print("show filters for playgrounds")
    }
    
    func secondCellDidTap() {
        print("show filters for cafe")
    }
    
    func thirdCellDidTap() {
        print("show filters for courses")
    }
    
    func fourthCellDidTap() {
        print("show filters for schools")
    }
    
    func fifthCellDidTap() {
        print("show filters for clinics")
    }
    
    func sixthCellDidTap() {
        print("show filters for shops")
    }
    
    
}
