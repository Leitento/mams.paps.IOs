

import UIKit

final class OnboardingSlide: UIView {
    
    private enum Constants {
        static let aspectRatioMultiplier: CGFloat = 529 / 412
        static let titleHeight: CGFloat = 71
        static let titleWidth: CGFloat = 148
    }
    
    // MARK: - Private properties
    private var slide: Slide {
        didSet {
            imageTitle.image = slide.title
            imageView.image = slide.image
        }
    }
    
    private lazy var imageTitle: UIImageView = {
        let imageTitle = UIImageView()
        imageTitle.contentMode = .scaleAspectFit
        imageTitle.image = slide.title
        return imageTitle
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = slide.image
        return imageView
    }()

    // MARK: - Life Cycle
    init(slide: Slide) {
        self.slide = slide
        super.init(frame: .zero)
        addSubviews(imageTitle, imageView, translatesAutoresizingMaskIntoConstraints: false)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setupLayout() {
        NSLayoutConstraint.activate([
            
            imageTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageTitle.heightAnchor.constraint(equalToConstant: Constants.titleHeight),
            imageTitle.widthAnchor.constraint(equalToConstant: Constants.titleWidth),
            
            imageView.topAnchor.constraint(equalTo: imageTitle.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: Constants.aspectRatioMultiplier),
        ])
    }
}
