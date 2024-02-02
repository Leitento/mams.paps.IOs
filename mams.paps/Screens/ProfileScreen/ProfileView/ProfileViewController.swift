//
//  ProfileViewController.swift
//  mams.paps
//
//  Created by Юлия Кагирова on 25.12.2023.
//

import UIKit

class ProfileViewController: UIViewController {

    enum Section: Hashable {
        case header
        case banner
        case buttons
    }
    enum Cell: Hashable {
        case header(profile: ProfileModel)
        case banner(banner: BannerModel)
        case buttons
    }

    //MARK: - Properties

    typealias DataSource = UICollectionViewDiffableDataSource<Section, Cell>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Cell>
    weak var profileCoordinator: ProfileScreenCoordinator?
    
    
    //MARK: - Private Properties
    
    private var viewModel: ProfileViewModelProtocol
    
    private lazy var dataSource = makeDataSource()
    private var snapshot: Snapshot {
        dataSource.snapshot()
    }
    private var layoutConfiguration: UICollectionViewCompositionalLayoutConfiguration = {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .vertical
        return config
    }()
    private lazy var layout = UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
        guard let sections = self?.snapshot.sectionIdentifiers,
              let section = sections[safeIndex: sectionIndex] else { return nil }
        switch section {
        case .header:
            return self?.setupHeaderLayout()
        case .banner:
            return self?.setupBannerLayout()
        case .buttons:
            return self?.setupButtonsLayout()
        }
    }, configuration: layoutConfiguration)

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ProfileCollectionViewCellWithBanner.self,
                                forCellWithReuseIdentifier: ProfileCollectionViewCellWithBanner.id)
        collectionView.register(ProfileCollectionViewCell.self,
                                forCellWithReuseIdentifier: ProfileCollectionViewCell.id)
        collectionView.register(ProfileHeaderView.self,
                                forCellWithReuseIdentifier: ProfileHeaderView.id)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
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
        viewModel.test()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

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
            heightDimension: .absolute(150)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: -10,
            leading: 0,
            bottom: 0,
            trailing: -20
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
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(368)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 20,
            leading: 20,
            bottom: 40,
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
            case .header(let profile):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileHeaderView.id,
                                                                    for: indexPath) as?  ProfileHeaderView
                else {
                    return  UICollectionViewCell()
                }
                cell.configuredCell(profile: profile)
                return  cell

            case .banner(let banner):
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ProfileCollectionViewCellWithBanner.id,
                    for: indexPath
                ) as? ProfileCollectionViewCellWithBanner
                else {
                    return UICollectionViewCell()
                }
                return cell

            case .buttons:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.id,
                                                                    for: indexPath) as? ProfileCollectionViewCell
                else {
                    return UICollectionViewCell()
                }
                return cell
            }
        }
    }
    
    private func makeHeaderProvider(profile: ProfileModel) -> (UICollectionView, String, IndexPath)
    -> UICollectionReusableView? {
        
        return { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else { return nil }
            guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind, withReuseIdentifier: ProfileHeaderView.id, for: indexPath) as? ProfileHeaderView
            else { return nil}
            header.configuredCell(profile: profile)
            return header
        }
    }
    
    
    private func makeSnapshot(profile: Profile) {
        var snapshot = Snapshot()
        snapshot.appendSections([.header])
        snapshot.appendItems([.header(profile: profile.profileModel)], toSection: .header)
        snapshot.appendSections([.banner])
        snapshot.appendItems([.banner(banner: profile.bannerModel)], toSection: .banner)
        snapshot.appendSections([.buttons])
        snapshot.appendItems([.buttons], toSection: .buttons)
        dataSource.apply(snapshot) //конфигурит все
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
                ()
            }
        }
    }
    
    //MARK: - Event Handler
    
    @objc private func editRightButtonTapped() {
        print("editRightButtonTapped")
//        let profileEditScreen = ProfileEditScreenController()
//        self.navigationController?.pushViewController(profileEditScreen, animated: true)
        viewModel.didTappedEditProfile()
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {

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
        title.text = "Профиль"
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

