//
//  InfoFilterController.swift
//  mams.paps
//
//  Created by Kos on 28.02.2024.
//

import UIKit


final class InfoFilterController: UIViewController {
    
    
    //MARK: - Properties
    
    private var viewModel: InfoFilterLocationModelProtocol
    weak var delegate: InfoFilterButtonDelegate?
    private lazy var dataSource = makeDataSource()
    
    private lazy var collectionView: UICollectionView =  {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .systemBackground
        collectionView.register(InfoViewCellFilter.self, forCellWithReuseIdentifier: InfoViewCellFilter.identifier)
        collectionView.delegate = self
        return collectionView
    }()
    
    typealias DataSource = UICollectionViewDiffableDataSource <Int, Category>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Category>
    
    
    //MARK: - Cycle
    
    
    init(viewModel: InfoFilterLocationModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bindingModel()
        viewModel.getLocation()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Method
    
    private func bindingModel() {
        viewModel.stateChanger = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .loading:
                ()
            case .done( let categoryes):
                self.makeSnapshot(categoryes: categoryes)
            case .chooseCategory(let locations):
                chooseCategory(locations: locations)
            case .error(error: let error):
                print(error)


            }
        }
    }
    
    private func makeDataSource() -> DataSource {
        return DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, itemIdentifier in
            guard let self = self else { return UICollectionViewCell() }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoViewCellFilter.identifier, for: indexPath) as! InfoViewCellFilter
            cell.configurationCellCollection(with: itemIdentifier)
            return cell
        }
    }
    
    private func makeSnapshot(categoryes: [Category]) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(categoryes, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func chooseCategory(locations: [Location]) {
        delegate?.didSelectCategory(locations)
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
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
            heightDimension: .absolute(52.0))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(spacing)
        let section  = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets.init(top: 0,
                                                             leading: 0,
                                                             bottom: 0,
                                                             trailing: 0)
        section.interGroupSpacing = 0
        let lauout = UICollectionViewCompositionalLayout(section: section)
        return lauout
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .customOrange
        view.addSubviews(collectionView, translatesAutoresizingMaskIntoConstraints: false)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
        ])
    }
}

extension InfoFilterController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        viewModel.didTapCategory(category: item)
        
    }
}




