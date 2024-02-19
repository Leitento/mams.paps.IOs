

import UIKit

final class MainScreenViewController: UIViewController {
    
    // MARK: - Private properties
    private var mainScreenView: MainScreenView
    private var viewModel: MainScreenViewModelProtocol
    
    // MARK: - Life Cycle
    init(viewModel: MainScreenViewModelProtocol) {
        self.viewModel = viewModel
        self.mainScreenView = MainScreenView(user: viewModel.currentUser, mainMenu: viewModel.mainMenu)
        super.init(nibName: nil, bundle: nil)
        mainScreenView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainScreenView()
    }
    
    // MARK: - Private methods
    private func setupMainScreenView() {
        view = mainScreenView
        navigationController?.navigationBar.isHidden = true
    }
}

// MARK: - MainScreenViewProtocol
extension MainScreenViewController: MainScreenViewProtocol {
    func locationLabelTapped() {
        viewModel.locationDidTap()
    }
    
    func userNameLabelTapped() {
        viewModel.userNameDidTap()
    }
    
    func firstCellDidTap() {
        viewModel.showMapScreen()
    }
    
    func secondCellDidTap() {
        viewModel.showEventsScreen()
    }
    
    func thirdCellDidTap() {
        viewModel.showServicesScreen()
    }
    
    func fourthCellDidTap() {
        viewModel.showUsefulScreen()
    }
    
}
