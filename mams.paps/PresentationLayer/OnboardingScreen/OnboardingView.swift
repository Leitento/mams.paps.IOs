

import UIKit

protocol OnboardingViewDelegate: AnyObject {
    func nextButtonTapped()
}

protocol OnboardingViewProtocol {
    func updateView(with model: OnboardingViewModel)
}

final class OnboardingView: UIView {
    
    weak var delegate: OnboardingViewDelegate?
    
    var viewModel: OnboardingViewModel
    
    private enum Constants {
        static let horizontalSpacing: CGFloat = 16
        static let verticalSpacing: CGFloat = 44
        static let textLabelWidth: CGFloat = 280
        static let nextButtonWidth: CGFloat = 194
        static let nextButtonHeight: CGFloat = 50
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
    
    private lazy var nextButton: UIButton = {
        let agreeButton = UIButton(type: .system)
        agreeButton.translatesAutoresizingMaskIntoConstraints = false
        agreeButton.setTitle("Далее", for: .normal)
        agreeButton.setTitleColor(.black, for: .normal)
        agreeButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        agreeButton.layer.cornerRadius = 20
        agreeButton.backgroundColor = .yellow
        agreeButton.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
        return agreeButton
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .yellow
        pageControl.pageIndicatorTintColor = .systemGray
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()
    
    init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
        super.init(frame: UIScreen.main.bounds)
        setupView()
        addSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
    }
    
    private func addSubviews() {
        addSubview(imageView)
        addSubview(pageControl)
        addSubview(textLabel)
        addSubview(nextButton)
    }
    
    private func setupLayout() {
        
        let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: statusBarHeight ?? 52),
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            imageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 529/412),
            
            pageControl.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.verticalSpacing),
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            textLabel.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: Constants.verticalSpacing),
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            textLabel.widthAnchor.constraint(equalToConstant: Constants.textLabelWidth),
    
            nextButton.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: (Constants.verticalSpacing + 4)),
            nextButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: Constants.nextButtonHeight),
            nextButton.widthAnchor.constraint(equalToConstant: Constants.nextButtonWidth)
           
        ])
    }
    
    @objc func nextButtonTapped(_ sender: UIButton) {
        delegate?.nextButtonTapped()
    }
}

extension OnboardingView: OnboardingViewProtocol {
    func updateView(with model: OnboardingViewModel) {
        switch model.state {
        case .firstPage:
            imageView.image = UIImage(named: "FirstPage")
            pageControl.currentPage = 0
            textLabel.text = "От родителей\nродителям!"
        case .secondPage:
            imageView.image = UIImage(named: "SecondPage")
            pageControl.currentPage = 1
            textLabel.text = "Детям будет\nинтересно!"
        case .thirdPage:
            imageView.image = UIImage(named: "ThirdPage")
            pageControl.currentPage = 2
            textLabel.text = "Локации, которые подходят именно вашей семье"
        }
    }
}
