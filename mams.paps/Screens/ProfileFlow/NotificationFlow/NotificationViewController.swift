//
//  NotificationViewController.swift
//  mams.paps
//
//  Created by Юлия Кагирова on 17.02.2024.
//

import UIKit

final class NotificationViewController: UIViewController {
    
    weak var profileCoordinator: ProfileScreenCoordinator?
    
    //MARK: - Private Properties
    
    private var backgroundView: UIView = {
        var view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = LayoutConstants.cornerRadius
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        //        scrollView.frame = CGRect(x: 0, y: 0, width: 300, height: 400)
        //        scrollView.center = view.center
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        //        scrollView.contentSize = CGSize(width: 300, height: 800)
        //        scrollView.delegate = self
        scrollView.isScrollEnabled = true
        scrollView.scrollsToTop = true
        return scrollView
    }()
    
    private lazy var contentView = UIView()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        setupUI()
        //        descriptionName.frame.size = scrollView.contentSize
        //        scrollView.contentOffset = CGPoint(x: 150, y: 150)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: - Private Methods
    
    private func setupUI() {
            self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(
                title: "Уведомления",
                style: .done,
                target: self,
                action: nil)
            navigationController?.navigationBar.tintColor = .customGrey
        view.layer.cornerRadius = LayoutConstants.cornerRadius
        view.backgroundColor = .customOrange
            
        view.addSubview(scrollView)
        scrollView.addSubviews(contentView)
        contentView.addSubviews(backgroundView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            backgroundView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                                constant: LayoutConstants.defaultOffSet),
            backgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                    constant: LayoutConstants.defaultOffSet),
            backgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                     constant: -LayoutConstants.defaultOffSet)
        ])
    }
}
