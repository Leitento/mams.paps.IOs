import UIKit

protocol  InfoFilterButtonDelegate:AnyObject {
    func didSelectCategory(_ categiry: [Location])
}


final class InfoLocationController: UIViewController {
    
    
    //MARK: - Properties
    
    private var viewModel: InfoLocationModelProtocol
    private lazy var dataSource = makeDataSource()
    
    private var infoFilterViewDelegate = InfoFilterView()
    private lazy var loader = ActivityIndicator()
    private var infoFilterView: InfoFilterView!
    
    private lazy var collectionView: UICollectionView =  {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.register(InfoViewCell.self, forCellWithReuseIdentifier: InfoViewCell.identifier)
        return collectionView
    }()
    
    typealias DataSource = UICollectionViewDiffableDataSource <Int, Location>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Location>
    
    //MARK: - Life Cycle
    
    init(viewModel: InfoLocationModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
       
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTitleInNavigationBar(title: "WhatNearby.Title".localized, 
                                  textColor: .black,
                                  backgroundColor: .white,
                                  isLeftItem: true)
        setupCollectionView()
        infoFilterViewDelegate = infoFilterView
        infoFilterViewDelegate.delegate = self
        bindingModel()
        viewModel.getLocation()
        
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Method
    
    private func makeDataSource() -> DataSource {
        return DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, itemIdentifier in
            guard let self = self else { return UICollectionViewCell() }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoViewCell.identifier, for: indexPath) as! InfoViewCell
            cell.configurationCellCollection(with: itemIdentifier)
            return cell
        }
    }
    
    private func makeSnapshot(locations: [Location]) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(locations, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func bindingModel() {
        viewModel.stateChanger = { [weak self] state in
            guard let self = self else { return }
            switch state {
//            case .initing:
//                self.loader.activityIndicatorEnabled(true)
            case .loading:
                self.loader.activityIndicatorEnabled(true)
            case .done(let locations):
                self.loader.activityIndicatorEnabled(false)
                self.makeSnapshot(locations: locations)
            case .filtered(let locations):
                self.makeSnapshot(locations: locations)
            case .showFilterView(let locations):
                self.showFilterView(locations: locations)
            case .error(error: let error):
                print(error)

}
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let spacing: CGFloat = LayoutConstants.spacing
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(200.0))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(spacing)
        let section  = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets.init(top: spacing,
                                                             leading: spacing,
                                                             bottom: spacing,
                                                             trailing: spacing)
        section.interGroupSpacing = spacing
        let lauout = UICollectionViewCompositionalLayout(section: section)
        return lauout
    }
    
    
        
    private func setupCollectionView() {
        collectionView.backgroundColor = .customOrange
        if infoFilterView == nil {
            infoFilterView = InfoFilterView()
        }
        infoFilterView.backgroundColor = .customOrange
        view.addSubviews(collectionView, loader, infoFilterView
                         ,translatesAutoresizingMaskIntoConstraints: false)
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            
            infoFilterView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            infoFilterView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            infoFilterView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: infoFilterView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
        ])
    }
    
    private func showFilterView(locations: [Location]) {
        let viewModel = InfoFilterModel(locations: locations)
        let infoFilterController = InfoFilterController(viewModel: viewModel)
        infoFilterController.delegate = self
        addChild(infoFilterController)
        
        view.insertSubview(infoFilterController.view, belowSubview: infoFilterView)
        
        
        infoFilterController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoFilterController.view.leadingAnchor.constraint(equalTo: infoFilterView.leadingAnchor, constant: LayoutConstants.spacing),
            infoFilterController.view.trailingAnchor.constraint(equalTo: infoFilterView.trailingAnchor, constant: -LayoutConstants.spacing),
            infoFilterController.view.topAnchor.constraint(equalTo: infoFilterView.bottomAnchor),
            infoFilterController.view.heightAnchor.constraint(equalToConstant: 8*52)
        ])
        
        infoFilterController.didMove(toParent: self)
        
    }
    
    
    @objc func filterButtonTapped() {
        viewModel.switchToNextFlow()
        view.backgroundColor = .white.darken(by: 0.25)
        collectionView.backgroundColor = .customOrange.darken(by: 0.25)
        infoFilterView.backgroundColor = .customOrange.darken(by: 0.25)
        updateCellContentViewBackground(color: .white.darken(by: 0.25))
    }
}


// MARK: - Extension

extension InfoLocationController: InfoFilterButtonDelegate {
    func didSelectCategory(_ category: [Location]) {
        viewModel.didTapCategory(category)
        view.backgroundColor = .white
        collectionView.backgroundColor = .customOrange
        infoFilterView.backgroundColor = .customOrange
        updateCellContentViewBackground(color: .white)
    }
}

extension InfoLocationController {
    
    func updateCellContentViewBackground(color: UIColor) {
        for indexPath in collectionView.indexPathsForVisibleItems {
            if let cell = collectionView.cellForItem(at: indexPath) as? InfoViewCell {
                cell.contentView.backgroundColor = color
            }
        }
    }
}
