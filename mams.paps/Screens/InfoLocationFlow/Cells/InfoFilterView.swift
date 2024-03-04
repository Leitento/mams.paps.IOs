import UIKit


final class InfoFilterView: UIView {
    
    //MARK: - Properties
    
    enum Constants {
        static let sliderImage = UIImage(systemName: "slider.horizontal.3")
    }
      
    weak var delegate: InfoLocationController?
    
     lazy var filterButton: UIButton = {
        let filter = UIButton()
        filter.setTitle("Выберите категорию", for: .normal)
        filter.setTitleColor(.black, for: .normal)
        filter.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        filter.contentHorizontalAlignment = .left
        filter.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        return filter
    }()
    
    private lazy var imageSlider: UIButton = {
        let filter = UIButton()
        
        var image = UIImage(systemName: "slider.horizontal.3", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular))
        image = image?.withTintColor(.black, renderingMode: .alwaysOriginal)
        filter.setImage(image, for: .normal)
        return filter
    }()
    
    private lazy var stackFilter: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [filterButton, imageSlider])
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 0
        stack.backgroundColor = .white
        stack.layer.masksToBounds = true
        stack.layer.cornerRadius = 20
        stack.layoutMargins = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .customOrange
        setupSearchBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Method
    
    
    private func setupSearchBar() {
        addSubviews(stackFilter, translatesAutoresizingMaskIntoConstraints: false)
        NSLayoutConstraint.activate([
            stackFilter.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: LayoutConstants.spacing),
            stackFilter.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            stackFilter.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: LayoutConstants.spacing),
            stackFilter.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -LayoutConstants.spacing)
        ])
    }
    
    @objc private func filterButtonTapped() {
        if let delegate = delegate {
            delegate.filterButtonTapped()
        } else {
            print("Delegate is nil")
        }
    }
}
