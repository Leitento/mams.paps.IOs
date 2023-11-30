

import UIKit

final class OnboardingSlide: UIView {
    
    private enum Constants {
        static let aspectRatioMultiplier: CGFloat = 529 / 412
    }
    
    // MARK: - Private properties
    private var slide: Slide {
        didSet {
            imageView.image = slide.image
        }
    }
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = slide.image
        return imageView
    }()

    // MARK: - Life Cycle
    init(slide: Slide) {
        self.slide = slide
        super.init(frame: .zero)
        addSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func addSubviews() {
        addSubview(imageView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -48),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.aspectRatioMultiplier),
        ])
    }
}
