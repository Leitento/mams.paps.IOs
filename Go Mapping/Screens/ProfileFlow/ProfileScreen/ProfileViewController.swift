//
//  ProfileViewController.swift
//  mams.paps
//
//  Created by Юлия Кагирова on 25.12.2023.
//

import UIKit

protocol ProfileViewControllerDelegate: AnyObject {
    func favouriteButtonTapped()
    func myAddsButtonTapped()
    func notificationButtonTapped()
    func contactOfferButtonTapped()
    func aboutAppButtonTapped()
    func supportButtonTapped()
    func logoutButtonTapped()
}

final class ProfileViewController: UIViewController , UIScrollViewDelegate {
    
    enum Section: Hashable {
        case banner
        case buttons
    }
    enum Cell: Hashable {
        case banner(banner: BannerModel)
        case buttons(button: ButtonsModel)
    }
    
    //MARK: - Private Properties
    
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Cell>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Cell>
    private weak var profileCoordinator: ProfileScreenCoordinator?
    private var viewModel: ProfileViewModelProtocol
    private lazy var dataSource = makeDataSource()
    private var snapshot: Snapshot {
        dataSource.snapshot()
    }
    private var layoutConfiguration: UICollectionViewCompositionalLayoutConfiguration = {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .vertical
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(200)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        header.pinToVisibleBounds = true
        config.boundarySupplementaryItems = [header]

        return config
    }()
    private lazy var layout = UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
        guard let sections = self?.snapshot.sectionIdentifiers,
              let section = sections[safeIndex: sectionIndex] else { return nil }
        switch section {
        case .banner:
            return self?.setupBannerLayout()
        case .buttons:
            return self?.setupButtonsLayout()
        }
    }, configuration: layoutConfiguration)
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BannerProfileCell.self,
                                forCellWithReuseIdentifier: BannerProfileCell.identifier)
        collectionView.register(ButtonsProfileCell.self,
                                forCellWithReuseIdentifier: ButtonsProfileCell.identifier)
        collectionView.register(ProfileHeaderView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: ProfileHeaderView.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = true
        collectionView.delegate = self
        return collectionView
    }()
    
    //MARK: - Life Cycle
    
    init(viewModel: ProfileViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavBar()
        setupCollectionView()
        bindingModel()
        viewModel.didTappedGetProfile()
    }
    
    //MARK: - Private Methods
    
    private func setupNavBar() {
        createCustomNavigationBar()
        let editRightButton = createEditButton(imageName: "edit", selector: #selector(editRightButtonTapped))
        let customTitleView = createCustomTitleView()
        navigationItem.rightBarButtonItem = editRightButton
        navigationItem.titleView = customTitleView
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .customOrange
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupHeaderLayout() -> NSCollectionLayoutSection? {

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(150)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0
        )
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(50)
        )
        return section
    }
    
    private func setupBannerLayout() -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(130)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 20,
            leading: 20,
            bottom: 0,
            trailing: 20
        )
        return section
    }
    
    private func setupButtonsLayout() -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(66)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(66)
        )
      
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 20,
            leading: 20,
            bottom: 20,
            trailing: 20
        )
        return section
    }
    
    private func makeDataSource() -> DataSource {
        return DataSource(collectionView: collectionView) {
            collectionView,
            indexPath,
            itemIdentifier in
            switch itemIdentifier {
            case .banner:
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: BannerProfileCell.identifier,
                    for: indexPath
                ) as? BannerProfileCell
                else {
                    return UICollectionViewCell()
                }
                return cell
                
            case .buttons(let model):
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ButtonsProfileCell.identifier,
                    for: indexPath) as? ButtonsProfileCell
                else {
                    return UICollectionViewCell()
                }
                cell.configuredCell(button: model)
                return cell
            }
        }
    }
    
    private func makeHeaderProvider(profile: ProfileUser) -> (UICollectionView, String, IndexPath)
    -> UICollectionReusableView? {
        return { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else { return nil }
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind, withReuseIdentifier: ProfileHeaderView.identifier, for: indexPath) as? ProfileHeaderView
            else { return nil}
            header.configuredCell(profile: profile)
            return header
        }
    }
    
    private func makeSnapshot(profile: Profile) {
        var snapshot = Snapshot()
        snapshot.appendSections([.banner])
        snapshot.appendItems([.banner(banner: profile.bannerModel)], toSection: .banner)
        snapshot.appendSections([.buttons])
        profile.buttonsModel.forEach {
            snapshot.appendItems([.buttons(button: $0)], toSection: .buttons)
        }
        dataSource.supplementaryViewProvider = makeHeaderProvider(profile: profile.profileUser)
        dataSource.apply(snapshot)
    }
    
    private func bindingModel() {
        viewModel.stateChanger = { [weak self] state in
            guard let self else {
                return
            }
            switch state {
                
            case .loading:
                ()
            case .loaded(let profile):
                self.makeSnapshot(profile: profile)
            case .error:
                Alert.shared.alertError(viewController: self) {
                    
                }
            }
        }
    }
    
    //MARK: - Event Handler
    
    @objc private func editRightButtonTapped() {
        print("editRightButtonTapped")
        viewModel.didTappedEditProfile()
    }
}

extension ProfileViewController {
    func createCustomNavigationBar() {
        navigationItem.hidesBackButton = true
    }
    
    func createCustomTitleView() -> UIView {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 390, height: 50)
        
        let title = UILabel()
        title.textAlignment = .left
        title.font = .systemFont(ofSize: 20, weight: .medium)
        title.text = "Profile.header".localized
        title.textColor = .customGrey
        title.frame = CGRect(x: 20, y: 14, width: 114, height: 22)
        view.addSubview(title)
        return view
    }
    func createEditButton(imageName: String, selector: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "edit"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.tintColor = .customDarkBlue
        let editButton = UIBarButtonItem(customView: button)
        return editButton
    }
}

extension ProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = dataSource.itemIdentifier(for: indexPath) else { return }
        switch cell {
        case .banner(let banner):
            return
        case .buttons(let button):
            viewModel.didTappedButton(target: button.target)
            
        }
    }
}
