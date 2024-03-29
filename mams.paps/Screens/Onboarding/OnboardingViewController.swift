

import UIKit

final class OnboardingViewController: UIViewController {

    private enum Constants {
        static let horizontalSpacing: CGFloat = 20
        static let verticalSpacingMin: CGFloat = 16
        static let verticalSpacingMax: CGFloat = 44
        static let textLabelWidth: CGFloat = 264
        static let textLabelHeight: CGFloat = 52
        static let nextButtonCornerRadius: CGFloat = 20
        static let nextButtonHeight: CGFloat = 50
        static let pageControllBottom: CGFloat = -128
        static let pageControlHeight: CGFloat = 12
        static let aspectRatioMultiplier: CGFloat = 529 / 412
    }

    // MARK: - Private properties
    private var viewModel: OnboardingViewModelProtocol
    private var onboardingSlide: OnboardingSlide
    private var onboardingSlides: [OnboardingSlide] = []

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        return scrollView
    }()

    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = viewModel.slides.count
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = .yellow
        pageControl.pageIndicatorTintColor = .systemGray
        pageControl.addTarget(self, action: #selector(pageControlTapHandler(_:)), for: .touchUpInside)
        return pageControl
    }()

    private lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.font = .systemFont(ofSize: 18, weight: .regular)
        textLabel.textColor = .black
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 2
        textLabel.text = viewModel.slides[viewModel.currentSlide].text
        return textLabel
    }()

    private lazy var nextButton: UIButton = {
        let nextButton = UIButton(type: .system)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitle("Onboarding.NextButton".localized, for: .normal)
        nextButton.setTitleColor(.black, for: .normal)
        nextButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        nextButton.layer.cornerRadius = Constants.nextButtonCornerRadius
        nextButton.backgroundColor = .yellow
        nextButton.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
        return nextButton
    }()

    // MARK: - Life Cycle
    init(viewModel: OnboardingViewModelProtocol) {
        self.viewModel = viewModel
        self.onboardingSlide = OnboardingSlide(slide: viewModel.slides[viewModel.currentSlide])
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addSubviews()
        setupScrollView()
        setupConstraints()
        bindViewModel()
    }
    
    // MARK: - Private methods
    private func setupView() {
        view.backgroundColor = .white
    }

    private func addSubviews() {
        view.addSubview(scrollView)
        view.addSubview(pageControl)
        view.addSubview(textLabel)
        view.addSubview(nextButton)
    }

    private func setupScrollView() {
        onboardingSlides = viewModel.slides.map { OnboardingSlide(slide: $0) }

        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(onboardingSlides.count), height: view.frame.width)
        for i in 0..<onboardingSlides.count {
            let onboardingSlide = onboardingSlides[i]
            scrollView.addSubview(onboardingSlide)
            onboardingSlide.frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
        }
    }

    private func setupConstraints() {
        
        let imageHeight = view.frame.width * Constants.aspectRatioMultiplier + 48
        let totalItemsHeight = imageHeight + Constants.nextButtonHeight + Constants.textLabelHeight + Constants.pageControlHeight
        let availableHeight = view.frame.height - totalItemsHeight
        let verticalSpacingMin: CGFloat = availableHeight / 4
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: Constants.pageControlHeight),
            pageControl.topAnchor.constraint(equalTo: view.topAnchor, constant: imageHeight + min(verticalSpacingMin, Constants.verticalSpacingMax)),
            
            textLabel.topAnchor.constraint(lessThanOrEqualTo: pageControl.bottomAnchor, constant: min(verticalSpacingMin, Constants.verticalSpacingMax)),
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLabel.widthAnchor.constraint(equalToConstant: Constants.textLabelWidth),
            textLabel.heightAnchor.constraint(equalToConstant: Constants.textLabelHeight),
            
            nextButton.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: min(verticalSpacingMin, Constants.verticalSpacingMax)),
            nextButton.heightAnchor.constraint(equalToConstant: Constants.nextButtonHeight),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.horizontalSpacing),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.horizontalSpacing)
        ])
    }
    
    private func bindViewModel() {
        viewModel.stateDidChange = { [weak self] state in
            guard let self = self else { return }
            let currentSlide = viewModel.slides[viewModel.currentSlide]
            textLabel.text = currentSlide.text
            pageControl.currentPage = viewModel.currentSlide
        }
    }

    @objc private func nextButtonTapped(_ sender: UIButton) {
        let nextPage = min(pageControl.currentPage + 1, onboardingSlides.count)
        if nextPage == onboardingSlides.count {
            viewModel.getNextFlow()
        } else {
            scrollView.scrollTo(horizontalPage: nextPage, animated: true)
        }
    }

    @objc private func pageControlTapHandler(_ sender: UIPageControl) {
        scrollView.scrollTo(horizontalPage: sender.currentPage, animated: true)
    }
}

    // MARK: - UIScrollViewDelegate
extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        
        let currentSlide = viewModel.slides[pageControl.currentPage]
        textLabel.text = currentSlide.text
    }
}

    // MARK: - UIScrollView extension
extension UIScrollView {
    func scrollTo(horizontalPage: Int? = 0, verticalPage: Int? = 0, animated: Bool? = true) {
        var frame: CGRect = self.frame
        frame.origin.x = frame.size.width * CGFloat(horizontalPage ?? 0)
        frame.origin.y = frame.size.width * CGFloat(verticalPage ?? 0)
        self.scrollRectToVisible(frame, animated: animated ?? true)
    }
}
