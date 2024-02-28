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
        return collectionView
    }()
    
    typealias DataSource = UICollectionViewDiffableDataSource <Int, Location>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Location>
    
    
    //MARK: - Cycle
    
    
    init(viewModel: InfoFilterLocationModelProtocol) {
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
            case .done:
                self.makeSnapshot()
            case .error(error: let error):
                print(error)
            }
        }
    }
    
    private func makeDataSource() -> DataSource {
        return DataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, itemIdentifier in
            guard let self = self else { return UICollectionViewCell() }
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoViewCellFilter.identifier, for: indexPath) as! InfoViewCellFilter
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


