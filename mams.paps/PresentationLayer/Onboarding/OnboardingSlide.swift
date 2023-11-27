

import UIKit

final class OnboardingSlide: UIView {
    
//    var viewModel: OnboardingViewModel? {
//        didSet {
//            updateView()
//        }
//    }
    
    let slide: Slide
    
    private enum Constants {
        static let multiplier: CGFloat = 529/412
    }
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = .systemFont(ofSize: 18, weight: .regular)
        textLabel.textColor = .black
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 2
        return textLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupLayout()
    }
    
    init(slide: Slide) {
        self.slide = slide
        imageView.image = slide.image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(imageView)
    }
    
    private func setupLayout() {
                
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -48),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.multiplier),
        ])
    }
    
//    private func updateView() {
//        guard let viewModel = viewModel else { return }
//        imageView.image = viewModel.image
//    }
}
