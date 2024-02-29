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
        collectionView.backgroundColor = .systemBackground
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
        bindingModel()
        viewModel.getLocation()
        setupCollectionView()
        infoFilterViewDelegate = infoFilterView
        infoFilterViewDelegate.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Method
    
    private func makeDataSource() -> DataSource {
        return DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, itemIdentifier in
            guard let self = self else { return UICollectionViewCell() }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoViewCell.identifier, for: indexPath) as! InfoViewCell
            let location = self.viewModel.locations[indexPath.row]
            cell.configurationCellCollection(with: location)
            return cell
        }
    }
    
    private func makeSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.locations, toSection: 0)
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
            case .done:
                self.loader.activityIndicatorEnabled(false)
                self.makeSnapshot()
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
        view.addSubviews(infoFilterView, collectionView, loader, translatesAutoresizingMaskIntoConstraints: false)
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
    
    @objc func filterButtonTapped() {
//        viewModel.switchToNextFlow(delegate: self)
        let viewModel = InfoFilterModel()
        let locationCoordinatorVC = InfoFilterController(viewModel: viewModel)
        locationCoordinatorVC.modalPresentationStyle = .popover
        locationCoordinatorVC.preferredContentSize = CGSize(width: 300, height: 300)
        let locationPopoverVC = locationCoordinatorVC.popoverPresentationController
        locationPopoverVC?.permittedArrowDirections = .any
        locationPopoverVC?.sourceView = infoFilterView
        locationPopoverVC?.sourceRect = CGRect(x: infoFilterView.bounds.midX, y: infoFilterView.bounds.midY, width: 0, height: 0)
        locationPopoverVC?.delegate = locationCoordinatorVC
        present(locationCoordinatorVC, animated: true)
    }
}


// MARK: - Extension

extension InfoLocationController: InfoFilterButtonDelegate {
    func didSelectCategory(_ category: [Location]) {
        viewModel.didTapCategory(category)
    }
}
