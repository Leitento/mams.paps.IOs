

import UIKit

final class OnboardingPageViewController: UIPageViewController {
    
    var pages: [OnboardingViewController] = []
    
    var pagesViewModel: [OnboardingViewModel] = []
    
    var currentPage: Int = 0
    
    init(pagesViewModel: [OnboardingViewModel]) {
        self.pagesViewModel = pagesViewModel
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInitialPage(at: 0)
    }
    
    private func setInitialPage(at index: Int) {
        if let initialViewController = createViewController(atIndex: index) {
            setViewControllers([initialViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    private func createViewController(atIndex index: Int) -> OnboardingViewController? {
        guard index >= 0 && index < pagesViewModel.count else {
            return nil
        }
        
        if index < pages.count {
            return pages[index]
        }
        
        return configureOnboardingViewController(at: index)
        
    }
        
    private func configureOnboardingViewController(at index: Int) -> OnboardingViewController {
        let onboardingViewController = OnboardingViewController()
        let onboardingView = OnboardingView(viewModel: pagesViewModel[index])
        onboardingView.delegate = onboardingViewController
        onboardingView.updateView(with: pagesViewModel[index])
        onboardingViewController.view = onboardingView
        onboardingViewController.pageController = self
        pages.append(onboardingViewController)
        return onboardingViewController
    }    
}

extension OnboardingPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(where: { $0 === (viewController as? OnboardingViewController) }),
              currentIndex > 0
        else {
            return nil
        }
        
        let previousIndex = currentIndex - 1
        return createViewController(atIndex: previousIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(where: { $0 === (viewController as? OnboardingViewController) }),
              currentIndex < pagesViewModel.count
        else {
            return nil
        }
        
        let nextIndex = currentIndex + 1
        return createViewController(atIndex: nextIndex)
    }
}

extension OnboardingPageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let currentViewController = pageViewController.viewControllers?.first as? OnboardingViewController,
              let currentIndex = pages.firstIndex(where: { $0 === currentViewController })
        else {
            return
        }
        
        currentPage = currentIndex
    }
}

extension UIPageViewController {
    func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil, onLastPage: (() -> Void)? = nil) {
        guard let currentViewController = viewControllers?.first,
              let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentViewController) else {
            onLastPage?()
            return
        }
        setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
    }
}




