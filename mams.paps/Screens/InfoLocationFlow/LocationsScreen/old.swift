//import UIKit
//
//protocol  InfoFilterButtonDelegate: AnyObject {
//    func didSelectCategory(_ categiry: Category)
//}
//
//protocol  InfoLocationControllerDelegate: AnyObject {
//    func hideResultFilter()
//    func showFilter()
//}
//
//protocol InfoFilterButtonLabelDelegate: AnyObject {
//    func renameFilterLabel(category: String)
//}
//
//final class InfoLocationController: UIViewController {
//    
//    
//    //MARK: - Properties
//    
//    
//    private weak var delegate: InfoFilterControllerDelegate?
//    private var viewModel: InfoLocationModelProtocol
//    private lazy var dataSource = makeDataSource()
//    private lazy var loader = ActivityIndicator()
//    private var infoFilterView: InfoFilterView = InfoFilterView()
//     
//    private lazy var collectionView: UICollectionView =  {
//        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
//        collectionView.register(InfoViewCell.self, forCellWithReuseIdentifier: InfoViewCell.identifier)
//        collectionView.register(InfoHeaderLocation.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: InfoHeaderLocation.identifierHeader)
//        return collectionView
//    }()
//    
//    
//    
//    typealias DataSource = UICollectionViewDiffableDataSource <Int, Location>
//    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Location>
//    
//    //MARK: - Life Cycle
//    
//    init(viewModel: InfoLocationModelProtocol) {
//        self.viewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
//       
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        setupCollectionView()
//        infoFilterView.delegate = self
//        bindingModel()
//        viewModel.getLocation()
//
//        setupTitleInNavigationBar(title: "WhatNearby.Title".localized,
//                                  textColor: .black,
//                                  backgroundColor: .white,
//                                  isLeftItem: true)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    
//    //MARK: - Method
//    
//    private func makeDataSource() -> DataSource {
//        return DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoViewCell.identifier, for: indexPath) as? InfoViewCell else { return UICollectionViewCell() }
//            cell.configurationCellCollection(with: itemIdentifier)
//            return cell
//        }
//    }
//    
//    private func makeSnapshot(locations: [Location]) {
//        var snapshot = Snapshot()
//        snapshot.appendSections([0])
//        snapshot.appendItems(locations, toSection: 0)
//        dataSource.apply(snapshot, animatingDifferences: true)
//        updateHeader(withCount: locations.count)
//    }
//    
//    private func updateHeader(withCount count: Int) {
//        guard let headerView = collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 0)) as? InfoHeaderLocation else { return }
//        headerView.configurationHeader(with: count)
//    }
//    
//    private func makeHeaderProvider(locations: [Location]) -> DataSource.SupplementaryViewProvider {
//        return  { collectionView, kind, indexPath in
//            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: InfoHeaderLocation.identifierHeader, for: indexPath) as? InfoHeaderLocation else { return UICollectionViewCell() }
//            let numberOfCells = locations.count
//            sectionHeader.configurationHeader(with: numberOfCells)
//            return sectionHeader
//        }
//    }
//    
//    private func bindingModel() {
//        viewModel.stateChanger = { [weak self] state in
//            guard let self = self else { return }
//            switch state {
//            case .loading:
//                self.loader.activityIndicatorEnabled(true)
//            case .done(let locations):
//                self.loader.activityIndicatorEnabled(false)
//                self.dataSource.supplementaryViewProvider = self.makeHeaderProvider(locations: locations)
//                self.makeSnapshot(locations: locations)
//                view.backgroundColor = .white
//                tabBarController?.tabBar.barTintColor = .white
//                collectionView.backgroundColor = .customOrange
//                infoFilterView.backgroundColor = .customOrange
//                updateCellContentViewBackground(color: .white)
//            case .showFilterView(let locations):
////                self.dataSource.supplementaryViewProvider = self.makeHeaderProvider(locations: locations)
//                self.showFilterView(locations: locations)
//                view.backgroundColor = .white.darken(by: 0.25)
//                tabBarController?.tabBar.barTintColor = .white.darken(by: 0.25)
//                collectionView.backgroundColor = .customOrange.darken(by: 0.25)
//                infoFilterView.backgroundColor = .customOrange.darken(by: 0.25)
//                updateCellContentViewBackground(color: .white.darken(by: 0.25))
//            case .error(error: let error):
//                print(error)
//            }
//        }
//    }
//    
//    private func createLayout() -> UICollectionViewLayout {
//        let spacing: CGFloat = LayoutConstants.spacing
//        let itemSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(1.0),
//            heightDimension: .fractionalHeight(1.0))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
//        let groupSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(1.0),
//            heightDimension: .absolute(200.0))
//        let group = NSCollectionLayoutGroup.horizontal(
//            layoutSize: groupSize, subitems: [item])
//        group.interItemSpacing = .fixed(spacing)
//        let section  = NSCollectionLayoutSection(group: group)
//        section.contentInsets = NSDirectionalEdgeInsets.init(top: 15,
//                                                             leading: spacing,
//                                                             bottom: spacing,
//                                                             trailing: spacing)
//        section.interGroupSpacing = spacing
//        let header = createSectionHeader()
//        section.boundarySupplementaryItems = [header]
//        return UICollectionViewCompositionalLayout(section: section)
//    }
//    
//    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
//        let layoutSectionHEaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
//                                                             heightDimension: .estimated(1))
//        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize:
//                                                                                layoutSectionHEaderSize,
//                                                                              elementKind: UICollectionView.elementKindSectionHeader,
//                                                                              alignment: .top)
//        
////        layoutSectionHeader.pinToVisibleBounds = true
//        return layoutSectionHeader
//    }
//    
//    
//        
//    private func setupCollectionView() {
//        collectionView.backgroundColor = .white
//        view.addSubviews(collectionView, loader, infoFilterView,
//                         translatesAutoresizingMaskIntoConstraints: false)
//        infoFilterView.clipsToBounds = true
//        infoFilterView.layer.masksToBounds = true
//        NSLayoutConstraint.activate([
//            loader.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
//            loader.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
//            
//            infoFilterView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            infoFilterView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            infoFilterView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            
//            collectionView.topAnchor.constraint(equalTo: infoFilterView.bottomAnchor),
//            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            
//        ])
//    }
//    
//    private func showFilterView(locations: [Category]) {
//        let viewModel = InfoFilterModel(categoryes: locations)
//        let infoFilterController = InfoFilterController(viewModel: viewModel)
//        infoFilterController.delegate = self
//        delegate = infoFilterController
//        infoFilterController.delegateFilter = self
//        addChild(infoFilterController)
//        
//        view.insertSubview(infoFilterController.view, belowSubview: infoFilterView)
//        
//        infoFilterController.view.layer.cornerRadius = 20
//        infoFilterController.view.layer.masksToBounds = true
//        
//        infoFilterController.view.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            infoFilterController.view.leadingAnchor.constraint(equalTo: infoFilterView.leadingAnchor, constant: LayoutConstants.spacing),
//            infoFilterController.view.trailingAnchor.constraint(equalTo: infoFilterView.trailingAnchor, constant: -LayoutConstants.spacing),
//            infoFilterController.view.topAnchor.constraint(equalTo: infoFilterView.bottomAnchor, constant: -26),
//            infoFilterController.view.heightAnchor.constraint(equalToConstant: 8*52+26)
//        ])
//        infoFilterController.didMove(toParent: self)
//    }
//}
//
//
//// MARK: - Extension
//
//extension InfoLocationController: InfoFilterButtonDelegate {
//    
//    func didSelectCategory(_ category: Category) {
//        viewModel.didTapCategory(category)
//    }
//}
//
//extension InfoLocationController {
//    
//    func updateCellContentViewBackground(color: UIColor) {
//        for indexPath in collectionView.indexPathsForVisibleItems {
//            if let cell = collectionView.cellForItem(at: indexPath) as? InfoViewCell {
//                cell.contentView.backgroundColor = color
//            }
//        }
//    }
//}
//
//extension InfoLocationController: InfoLocationControllerDelegate {
//    func hideResultFilter() {
//        viewModel.hideFilter()
//        delegate?.hideFilterController()
//        
//    }
//
//    func showFilter() {
//        viewModel.switchToNextFlow()
//        
//    }
//
//     
//}
//extension Sequence where Iterator.Element: Hashable {
//    func unique() -> [Iterator.Element] {
//        var seen: Set<Iterator.Element> = []
//        return filter { seen.insert($0).inserted }
//    }
//}
//
//
//extension InfoLocationController: InfoFilterButtonLabelDelegate {
//    func renameFilterLabel(category: String) {
//        infoFilterView.updateCategoty(categoty: category)
//    }
//}
