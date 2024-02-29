

import UIKit

protocol InfoLocationCoordinatorProtocol: AnyObject {
    func switchToNextFlow(delegate: InfoFilterButtonDelegate, sourceView: UIView)
    func presentChildViewController(_ viewController: UIViewController)
}

final class InfoLocationCoordinator {
        
    // MARK: - Properties
    
    private weak var parentCoordinator: TabBarCoordinatorProtocol?
    private var childCoordinators: [CoordinatorProtocol] = []
    private var rootViewController: UIViewController?
    private var navigationController: UINavigationController?
        
    
    // MARK: - Life Cycle
    
    init(parentCoordinator: TabBarCoordinatorProtocol) {
        self.parentCoordinator = parentCoordinator
    }
    
    // MARK: - Private methods
    
    private func createNavigationController() -> UIViewController {
        let viewModel = InfoLocationModel(coordinator: self)
        let infoLocationController = InfoLocationController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: infoLocationController)
        navigationController.tabBarItem = UITabBarItem(title: "WhatNearby.Title".localized, image: UIImage(systemName: "location.circle"), tag: 1)
        self.navigationController = navigationController
        return navigationController
    }
    
    func presentChildViewController(_ viewController: UIViewController) {
        navigationController?.present(viewController, animated: true, completion: nil)
   }
}

// MARK: - CoordinatorProtocol

extension InfoLocationCoordinator: CoordinatorProtocol, InfoLocationCoordinatorProtocol {
     func start() -> UIViewController {
        createNavigationController()
    }
    
    func switchToNextFlow(delegate: InfoFilterButtonDelegate, sourceView: UIView) {
        let infoCoordinator = InfoFilterLocationCoordinator(parentCoordinator: self, parentController: delegate)
        let viewModel = InfoFilterModel()
        let locationCoordinatorVC = InfoFilterController(viewModel: viewModel)
        locationCoordinatorVC.modalPresentationStyle = .popover
        locationCoordinatorVC.preferredContentSize = CGSize(width: 300, height: 300)
        let locationPopoverVC = locationCoordinatorVC.popoverPresentationController
        locationPopoverVC?.sourceView = sourceView
        locationPopoverVC?.delegate = locationCoordinatorVC
        self.presentChildViewController(locationCoordinatorVC)
    }

}




