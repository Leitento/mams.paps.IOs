

import UIKit

protocol PopupViewProtocol: AnyObject {
    func filterDidTap(with itemIndex: Int)
}

final class PopupView: UIView {
    
    private enum Constants {
        static let padding: CGFloat = 20
        static let topViewHeight: CGFloat = 36
    }
    
    weak var delegate: PopupViewProtocol?
    
    // MARK: - Private properties
    private let popupMenu: [PopupMenuItem] = PopupMenuItem.make()
    
    private lazy var topView: UIView = {
        let topView = UIView()
        topView.backgroundColor = .white
        return topView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: viewLayout)
        collectionView.register(
            PopupCollectionViewCell.self,
            forCellWithReuseIdentifier: PopupCollectionViewCell.identifier)
        return collectionView
    }()
    
    private lazy var redView: UIView = {
        let redView = UIView()
        redView.backgroundColor = UIColor(named: "customRed")
        redView.layer.cornerRadius = 2
        return redView
    }()
    
    // MARK: - Life Cycle
    init() {
        super.init(frame: .zero)
        setupView()
        setupTopView()
        setupCollectionView()
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createBezierPath().cgPath
        layer.mask = shapeLayer
    }
    
    // MARK: - Private methods
    private func setupView() {
        backgroundColor = UIColor(named: "customOrange")
    }
    
    private func setupTopView() {
        
        topView.addSubviews(redView, translatesAutoresizingMaskIntoConstraints: false)
        
        NSLayoutConstraint.activate([
            redView.widthAnchor.constraint(equalToConstant: 32),
            redView.heightAnchor.constraint(equalToConstant: 4),
            redView.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            redView.centerYAnchor.constraint(equalTo: topView.centerYAnchor)
        ])
    }
    
    private func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func addSubviews() {
        addSubviews(
            topView,
            collectionView,
            translatesAutoresizingMaskIntoConstraints: false
        )
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: topAnchor),
            topView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight),
            
            collectionView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func createBezierPath() -> UIBezierPath {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: [.topLeft, .topRight],
                                cornerRadii: CGSize(width: Constants.topViewHeight,
                                                    height: Constants.topViewHeight)
                                )
        return path
    }
}

// MARK: - UICollectionViewDataSource
extension PopupView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, 
                        numberOfItemsInSection section: Int) -> Int {
        popupMenu.count
    }

    func collectionView(_ collectionView: UICollectionView, 
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PopupCollectionViewCell.identifier,
            for: indexPath) as? PopupCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setup(with: popupMenu[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PopupView: UICollectionViewDelegateFlowLayout {
    
    private func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        
        let itemsInRow: CGFloat = 2
        let totalSpacing: CGFloat = 2 * spacing + (itemsInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / itemsInRow
        return floor(finalWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = itemWidth(for: frame.width, spacing: Constants.padding)
        return CGSize(width: width, 
                      height: width)
    }

    func collectionView(_ collectionView: UICollectionView, 
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: Constants.padding, 
                     left: Constants.padding,
                     bottom: 0,
                     right: Constants.padding)
    }

    func collectionView(_ collectionView: UICollectionView, 
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.padding
    }

    func collectionView(_ collectionView: UICollectionView, 
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.padding
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        didSelectItemAt indexPath: IndexPath) {
        if collectionView.cellForItem(at: indexPath) is PopupCollectionViewCell {
            
            delegate?.filterDidTap(with: indexPath.item)
        
        }
    }
}
