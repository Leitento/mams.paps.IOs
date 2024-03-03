

import UIKit

final class FilterSettingsViewController: UIViewController {
    
    // MARK: - Private properties
    private var filterSettingsView: FilterSettingsView
    private var viewModel: FiltersSettingsViewModelProtocol
    
    // MARK: - Life Cycle
    init(viewModel: FiltersSettingsViewModelProtocol) {
        self.viewModel = viewModel
        self.filterSettingsView = FilterSettingsView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupView()
    }
    
    // MARK: - Private methods
    private func bindViewModel() {
        navigationController?.navigationBar.topItem?.backButtonTitle =
        "Filter".localized + " - " + viewModel.getFilterName()
        
        navigationController?.navigationBar.tintColor = .black
        
        let imageName = viewModel.getImageName()
        filterSettingsView.imageView.image = UIImage(named: imageName)
        filterSettingsView.labelText.text = viewModel.getLabelText() + "!"
    }
    
    private func setupView() {
        view.addSubviews(filterSettingsView, translatesAutoresizingMaskIntoConstraints: false)
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            filterSettingsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            filterSettingsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            filterSettingsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            filterSettingsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
