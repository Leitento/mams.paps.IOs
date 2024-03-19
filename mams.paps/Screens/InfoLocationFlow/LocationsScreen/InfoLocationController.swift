import UIKit
import SnapKit

protocol  InfoFilterButtonDelegate: AnyObject {
    func didSelectCategory(_ categiry: Category)
}

protocol  InfoLocationControllerDelegate: AnyObject {
    func hideResultFilter()
    func showFilter()
}

protocol InfoFilterButtonLabelDelegate: AnyObject {
    func renameFilterLabel(category: String)
}

final class InfoLocationController: UIViewController {


    //MARK: - Properties


    private weak var delegate: InfoFilterControllerDelegate?
    private var viewModel: InfoLocationModelProtocol
    private lazy var dataSource = makeDataSource()
    private lazy var loader = ActivityIndicator()
    private lazy var infoFilterView = InfoFilterView()
    private lazy var infoViewHeader = InfoViewHeader()

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
        infoViewHeader.isHidden = true
        setupCollectionView()
        infoFilterView.delegate = self
        bindingModel()
        viewModel.getLocation()
        setupTitleInNavigationBar(title: "WhatNearby.Title".localized,
                                  textColor: .black,
                                  backgroundColor: .white,
                                  isLeftItem: true)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    //MARK: - Method

    private func makeDataSource() -> DataSource {
        return DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoViewCell.identifier, for: indexPath) as? InfoViewCell else { return UICollectionViewCell() }
            cell.configurationCellCollection(with: itemIdentifier)
            return cell
        }
    }

    private func makeSnapshot(locations: [Location]) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(locations, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: true)
        updateHeader(withCount: locations.count)
    }
    
    private func updateHeader(withCount count: Int) {
        infoViewHeader.updateHeaderCount(withCount: count)
    }

    private func bindingModel() {
        viewModel.stateChanger = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .loading:
                self.loader.activityIndicatorEnabled(true)
            case .done(let locations):
                self.loader.activityIndicatorEnabled(false)
                self.makeSnapshot(locations: locations)
                updateCollectionView()
                view.backgroundColor = .white
                tabBarController?.tabBar.barTintColor = .white
                collectionView.backgroundColor = .customOrange
                infoFilterView.backgroundColor = .customOrange
                updateCellContentViewBackground(color: .white)
            case .showFilterView(let locations):
                self.showFilterView(locations: locations)
                view.backgroundColor = .white.darken(by: 0.25)
                tabBarController?.tabBar.barTintColor = .white.darken(by: 0.25)
                collectionView.backgroundColor = .customOrange.darken(by: 0.25)
                infoFilterView.backgroundColor = .customOrange.darken(by: 0.25)
                updateCellContentViewBackground(color: .white.darken(by: 0.25))
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
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 15,
                                                             leading: spacing,
                                                             bottom: spacing,
                                                             trailing: spacing)
        section.interGroupSpacing = spacing
        return UICollectionViewCompositionalLayout(section: section)
    }

    private func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHEaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                             heightDimension: .estimated(1))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize:
                                                                                layoutSectionHEaderSize,
                                                                              elementKind: UICollectionView.elementKindSectionHeader,
                                                                              alignment: .top)
        return layoutSectionHeader
    }
    
    private func updateCollectionView() {
        if  infoViewHeader.isHidden {
            collectionView.snp.remakeConstraints { update in
                update.top.equalTo(infoFilterView.snp.bottom)
                update.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            }
        } else {
            collectionView.snp.remakeConstraints { update in
                update.top.equalTo(infoViewHeader.snp.bottom)
                update.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            }
        }
    }

    private func setupCollectionView() {
        collectionView.backgroundColor = .white
        view.addSubviews(collectionView, loader,infoViewHeader, infoFilterView,
                         translatesAutoresizingMaskIntoConstraints: true)
        infoFilterView.clipsToBounds = true
        infoFilterView.layer.masksToBounds = true
        loader.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
        }
        infoFilterView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        infoViewHeader.snp.makeConstraints { make in
            make.top.equalTo(infoFilterView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(infoFilterView.snp.bottom)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func showFilterView(locations: [Category]) {
        let viewModel = InfoFilterModel(categoryes: locations)
        let infoFilterController = InfoFilterController(viewModel: viewModel)
        infoFilterController.delegate = self
        delegate = infoFilterController
        infoFilterController.delegateFilter = self
        addChild(infoFilterController)

        view.insertSubview(infoFilterController.view, belowSubview: infoFilterView)

        infoFilterController.view.layer.cornerRadius = 20
        infoFilterController.view.layer.masksToBounds = true

        infoFilterController.view.translatesAutoresizingMaskIntoConstraints = false
        let heightView = CGFloat((infoFilterController.numberOfCells ?? 0) * 52)
        NSLayoutConstraint.activate([
            infoFilterController.view.leadingAnchor.constraint(equalTo: infoFilterView.leadingAnchor, constant: LayoutConstants.spacing),
            infoFilterController.view.trailingAnchor.constraint(equalTo: infoFilterView.trailingAnchor, constant: -LayoutConstants.spacing),
            infoFilterController.view.topAnchor.constraint(equalTo: infoFilterView.bottomAnchor),
            infoFilterController.view.heightAnchor.constraint(equalToConstant: heightView)
        ])
//        infoFilterController.view.snp.makeConstraints { make in
//            make.leading.equalTo(infoFilterView).offset(LayoutConstants.spacing)
//            make.trailing.equalTo(infoFilterView).offset(-LayoutConstants.spacing)
//            make.top.equalTo(infoFilterView.snp.bottom).offset(-26)
//            make.height.equalTo(infoFilterController.view.snp.height).offset(26)
//        }
        infoFilterController.didMove(toParent: self)
    }
}


// MARK: - Extension

extension InfoLocationController: InfoFilterButtonDelegate {

    func didSelectCategory(_ category: Category) {
        infoViewHeader.isHidden = false
        viewModel.didTapCategory(category)
        
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

extension InfoLocationController: InfoLocationControllerDelegate {
    func hideResultFilter() {
        viewModel.hideFilter()
        delegate?.hideFilterController()
        infoViewHeader.isHidden = true
    }

    func showFilter() {
        viewModel.switchToNextFlow()
    }
}

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}

extension InfoLocationController: InfoFilterButtonLabelDelegate {
    func renameFilterLabel(category: String) {
        infoFilterView.updateCategoty(categoty: category)
    }
}

