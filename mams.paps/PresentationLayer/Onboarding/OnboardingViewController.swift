

import UIKit

final class OnboardingViewController: UIViewController {
    
    private enum Constants {
        static let horizontalSpacing: CGFloat = 16
        static let verticalSpacing: CGFloat = 44
        static let textLabelWidth: CGFloat = 280
        static let nextButtonWidth: CGFloat = 194
        static let nextButtonHeight: CGFloat = 50
        static let pageControllBottom: CGFloat = -128
    }
    
    private lazy var pages: [OnboardingViewModel] = [OnboardingViewModel(state: .firstPage),
                                                        OnboardingViewModel(state: .secondPage),
                                                        OnboardingViewModel(state: .thirdPage)]

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
        pageControl.numberOfPages = pages.count
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
        return textLabel
    }()
    
    private lazy var nextButton: UIButton = {
        let nextButton = UIButton(type: .system)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitle("Далее".localized, for: .normal)
        nextButton.setTitleColor(.black, for: .normal)
        nextButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        nextButton.layer.cornerRadius = 20
        nextButton.backgroundColor = .yellow
        nextButton.addTarget(self, action: #selector(nextButtonTapped(_:)), for: .touchUpInside)
        return nextButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addSubviews()
        setupScrollView()
        setupConstraints()
    }
    
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
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(pages.count), height: view.frame.width)
        for i in 0..<pages.count {
            let onboardingSlide = OnboardingSlide()
            onboardingSlide.viewModel = pages[i]
            scrollView.addSubview(onboardingSlide)
            onboardingSlide.frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
        }
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.horizontalSpacing),
            nextButton.heightAnchor.constraint(equalToConstant: Constants.nextButtonHeight),
            nextButton.widthAnchor.constraint(equalToConstant: Constants.nextButtonWidth),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            textLabel.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -Constants.verticalSpacing),
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLabel.widthAnchor.constraint(equalToConstant: Constants.textLabelWidth),
            
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: Constants.pageControllBottom),
            
        ])
    }
    
    @objc func nextButtonTapped(_ sender: UIButton) {
        var currentPage = pageControl.currentPage
        currentPage += 1
        
        if currentPage >= pages.count {
            print("Переход на экран авторизации")
            return
        }
        
        scrollView.scrollTo(horizontalPage: currentPage, animated: true)
    }
    
    @objc func pageControlTapHandler(_ sender: UIPageControl) {
        scrollView.scrollTo(horizontalPage: sender.currentPage, animated: true)
    }
}

extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(pageIndex)
        textLabel.text = pages[Int(pageIndex)].text
    }
}
