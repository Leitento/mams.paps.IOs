

import UIKit

final class FilterSettingsViewController: UIViewController {
    
    // MARK: - Private properties
    private var filterSettingsView: FilterSettingsView
    private var viewModel: FiltersSettingsViewModelProtocol
    private var selectedFilterIndex: Int = 0
    
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
        setupFilterOptions()
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
    
    private func setupFilterOptions() {
        filterSettingsView.addTableView(to: filterSettingsView.leftView,
                                        withData: viewModel.getFilterOptions(),
                                        delegate: self,
                                        dataSource: self)
        filterSettingsView.addTableView(to: filterSettingsView.rightView,
                                        withData: viewModel.getSettingsOption(for: selectedFilterIndex),
                                        delegate: self,
                                        dataSource: self)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension FilterSettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView === filterSettingsView.leftView.subviews.first {
            return viewModel.getFilterOptions().count
        } else if tableView === filterSettingsView.rightView.subviews.first {
            return viewModel.getSettingsOption(for: selectedFilterIndex).count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView === filterSettingsView.leftView.subviews.first {
            guard let leftCell = tableView.dequeueReusableCell(withIdentifier: FiltersTableViewCell.identifier,
                                                               for: indexPath) as? FiltersTableViewCell
            else {
                return UITableViewCell()
            }
            
            tableView.separatorStyle = .none
            
            let filterOption = viewModel.getFilterOptions()[indexPath.row]
            leftCell.setup(with: filterOption)
            
            let selectedIndexPath = IndexPath(row: 0, section: 0)
            tableView.selectRow(at: selectedIndexPath, animated: false, scrollPosition: .none)
            leftCell.contentView.backgroundColor = UIColor(named: "customRed")
            leftCell.updateSelectedItems()
            
            return leftCell
            
        } else if tableView === filterSettingsView.rightView.subviews.first {
            guard let rightCell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier,
                                                                for: indexPath) as? SettingsTableViewCell
            else {
                return UITableViewCell()
            }
            
            tableView.separatorColor = UIColor(named: "customRed")
            tableView.separatorInset = UIEdgeInsets(
                top: 0,
                left: 10,
                bottom: 0,
                right: 10
            )
            
            let settingsOption = viewModel.getSettingsOption(for: selectedFilterIndex)[indexPath.row]
            rightCell.setup(with: settingsOption)
            
            return rightCell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let viewHeight = filterSettingsView.leftView.frame.height
        let numberOfRows = viewModel.getFilterOptions().count
        let spacing: CGFloat = 20 * 2
        let availableHeight = viewHeight - spacing
        let rowHeight = availableHeight / CGFloat(numberOfRows)
        return min(rowHeight, 50)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView === filterSettingsView.leftView.subviews.first as? UITableView {
            guard let leftView = filterSettingsView.leftView.subviews.first as? UITableView else {
                return
            }
                
            guard let cell = tableView.cellForRow(at: indexPath) as? FiltersTableViewCell else {
                return
            }
            
            cell.contentView.backgroundColor = UIColor(named: "customRed")
            cell.updateSelectedItems()
            selectedFilterIndex = indexPath.row
        
            if let rightView = filterSettingsView.rightView.subviews.first as? UITableView {
                rightView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView === filterSettingsView.leftView.subviews.first {
            guard let cell = tableView.cellForRow(at: indexPath) as? FiltersTableViewCell else {
                return
            }
            
            cell.contentView.backgroundColor = .clear
            cell.updateSelectedItems()
        }
    }
}
