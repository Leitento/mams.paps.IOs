import UIKit




final class InfoFilterView: UIView {
    
    //MARK: - Properties
    
    enum Constants {
        static let sliderImage =  "slider.horizontal.3"
        static let imageClear = "xmark"
    }

    weak var delegate: InfoLocationControllerDelegate?
    
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
        var image = UIImage( systemName: Constants.sliderImage, withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular))
        image = image?.withTintColor(.black, renderingMode: .alwaysOriginal)
        filter.setImage(image, for: .normal)
        filter.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        return filter
    }()
    
    private lazy var imageClear: UIButton = {
        let filter = UIButton()
        var image = UIImage(systemName: Constants.imageClear, withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .regular))
        image = image?.withTintColor(.darkGray, renderingMode: .alwaysOriginal)
        filter.setImage(image, for: .normal)
        filter.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        filter.isHidden = true
        return filter
    }()
    
    private lazy var stackFilter: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [filterButton, imageSlider , imageClear])
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 0
        stack.backgroundColor = .white
        stack.layer.masksToBounds = false
        stack.layer.cornerRadius = 20
        stack.layoutMargins = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layer.shadowColor = UIColor.gray.cgColor
        stack.layer.shadowOffset = CGSize(width: 0, height: 1)
        stack.layer.shadowRadius = 20
        
         let shadowSize: CGFloat = 5
         let contactRect = CGRect(x: shadowSize, y: stack.bounds.height  , width: stack.bounds.width  , height: shadowSize)
         
         layer.shadowPath = UIBezierPath(ovalIn: contactRect).cgPath
        return stack
    }()
    
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .clear
        setupSearchBar()
        clipsToBounds = true
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Method
    
    
    private func setupSearchBar() {
        addSubviews(stackFilter, translatesAutoresizingMaskIntoConstraints: false)
        NSLayoutConstraint.activate([
            stackFilter.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: LayoutConstants.spacing),
            stackFilter.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -1),
            stackFilter.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: LayoutConstants.spacing),
            stackFilter.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -LayoutConstants.spacing),
        ])
    }
    
    func updateCategoty(categoty: String) {
        filterButton.setTitle(categoty, for: .normal)
    }
    
    func hideShadow(hideShadow: Float ) {
        stackFilter.layer.shadowOpacity = hideShadow
    }
        
    private func changeState(isHidden: Bool) {
        imageSlider.isHidden = isHidden
        imageClear.isHidden = !isHidden
        filterButton.isEnabled = !isHidden
    }
    
    @objc private func filterButtonTapped() {
        
        delegate?.showFilter()
        changeState(isHidden: true)
    }
    
    @objc private func clearButtonTapped() {
        delegate?.hideResultFilter()
        changeState(isHidden: false)
        filterButton.setTitle("Выберите категорию", for: .normal)
    }
}


//MARK: - Extension

extension InfoFilterView: InfoFilterButtonLabelDelegate {
    func renameFilterLabel(category: String) {
        filterButton.setTitle(category, for: .normal)
            print(category)
    }
}

