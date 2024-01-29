

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - Private properties
    private var mainView: MainView
    private var viewModel: MainViewModelProtocol
    
    // MARK: - Life Cycle
    init(viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
        self.mainView = MainView(user: viewModel.currentUser, mainMenu: viewModel.mainMenu)
        super.init(nibName: nil, bundle: nil)
        mainView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Private methods
    private func setupMainView() {
        view = mainView
    }
}

    // MARK: - MainViewDelegate
extension MainViewController: MainViewDelegate {
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