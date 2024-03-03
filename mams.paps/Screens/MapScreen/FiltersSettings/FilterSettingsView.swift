

import UIKit

final class FilterSettingsView: UIView {
    
    private enum Constants {
        static let aspectRatioMultiplier: CGFloat = 153 / 390
        static let widthMultiplier: CGFloat = 295/390
        static let padding: CGFloat = 20
        static let cornerRadius: CGFloat = 20
        static let buttonHeight: CGFloat = 60
    }
    
    weak var delegate: MainScreenViewProtocol?
    
    // MARK: - Private properties
    private lazy var topView: UIView = {
        let topView = RoundedBottomView()
        topView.backgroundColor = .white
        return topView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView,
                                                       labelText])
        stackView.spacing = Constants.padding
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var labelText: UILabel = {
        let labelText = UILabel()
        labelText.translatesAutoresizingMaskIntoConstraints = false
        labelText.font = .systemFont(ofSize: 28,
                                     weight: .regular)
        labelText.textAlignment = .left
        labelText.numberOfLines = 0
        labelText.textColor = UIColor(named: "customDarkBlue")
        return labelText
    }()
    
    lazy var leftView: UIView = {
        let leftView = UIView()
        leftView.backgroundColor = .white
        
        leftView.layer.cornerRadius = Constants.cornerRadius
        leftView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        return leftView
    }()
    
    lazy var rightView: UIView = {
        let rightView = UIView()
        rightView.backgroundColor = .white
        
        rightView.layer.cornerRadius = Constants.cornerRadius
        rightView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
        return rightView
    }()
    
    private lazy var showButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("FilterSettingsView.Button".localized, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = UIColor(named: "customLightGrey")
        button.addTarget(self, action: #selector(showButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    func addTableView<T>(to view: UIView,
                      withData data: [T],
                      delegate: UITableViewDelegate,
                      dataSource: UITableViewDataSource) {
        let tableView = UITableView(frame: .zero, style: .plain)
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = delegate
        tableView.dataSource = dataSource
        tableView.register(FiltersTableViewCell.self, forCellReuseIdentifier: FiltersTableViewCell.identifier)
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.tag = view.tag
        tableView.rowHeight = UITableView.automaticDimension
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.cornerRadius),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Constants.cornerRadius),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: - Life Cycle
    init() {
        super.init(frame: .zero)
        setupView()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setupView() {
        backgroundColor = UIColor(named: "customOrange")
    }
    
    private func addSubviews() {
        addSubviews(
            topView,
            leftView,
            rightView,
            showButton,
            translatesAutoresizingMaskIntoConstraints: false
        )
        topView.addSubviews(
            stackView,
            translatesAutoresizingMaskIntoConstraints: false
        )
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            topView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            topView.heightAnchor.constraint(equalTo: widthAnchor,
                                            multiplier: Constants.aspectRatioMultiplier,
                                            constant: Constants.padding),
            
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, 
                                           constant: 5),
            stackView.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            stackView.widthAnchor.constraint(equalTo: widthAnchor,
                                             multiplier: 295/390),
            stackView.bottomAnchor.constraint(equalTo: topView.bottomAnchor,
                                              constant: -5),
            
            imageView.widthAnchor.constraint(equalTo: stackView.widthAnchor, 
                                             multiplier: 0.5,
                                             constant: -Constants.padding/2),
            imageView.heightAnchor.constraint(equalTo: topView.heightAnchor),
            labelText.widthAnchor.constraint(equalTo: stackView.widthAnchor,
                                             multiplier: 0.5,
                                             constant: -Constants.padding/2),
            
            leftView.topAnchor.constraint(equalTo: topView.bottomAnchor, 
                                          constant: 35),
            leftView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            leftView.trailingAnchor.constraint(equalTo: centerXAnchor, 
                                               constant: -5),
            leftView.bottomAnchor.constraint(equalTo: showButton.topAnchor,
                                             constant: -35),
            
            rightView.topAnchor.constraint(equalTo: topView.bottomAnchor, 
                                           constant: 35),
            rightView.leadingAnchor.constraint(equalTo: centerXAnchor, 
                                               constant: 5),
            rightView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            rightView.bottomAnchor.constraint(equalTo: showButton.topAnchor,
                                              constant: -35),
            
            showButton.topAnchor.constraint(equalTo: leftView.bottomAnchor,
                                            constant: 35),
            showButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight),
            showButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
                                                constant: Constants.padding),
            showButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
                                                 constant: -Constants.padding),
            showButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor,
                                               constant: -Constants.padding)
        ])
    }
    
    @objc private func showButtonTapped(_ sender: UIButton) {
        print("showButton tapped")
    }
}

