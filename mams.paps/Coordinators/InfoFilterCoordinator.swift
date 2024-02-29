//
//  InfoFilterLocationCoordinator.swift
//  mams.paps
//
//  Created by Kos  on 28.02.2024.
//

import UIKit


protocol InfoFilterCoordinatorProtocol: AnyObject {
    func switchToNextFlow()
    
}

final class InfoFilterLocationCoordinator {
        
    // MARK: - Properties
    
    private weak var parentCoordinator: InfoLocationCoordinatorProtocol?
    private let parentController: InfoFilterButtonDelegate
    private var childCoordinators: [CoordinatorProtocol] = []
    private var rootViewController: UIViewController?
    private var navigationController: UINavigationController?
    
    // MARK: - Private Properties
    
    
    // MARK: - Private methods
    
    private func createNavigationController() -> UIViewController {
        let viewModel = InfoFilterModel()
        let infoLocationController = InfoFilterController(viewModel: viewModel)
        infoLocationController.delegate = parentController
        let navigationController = UINavigationController(rootViewController: infoLocationController)
        self.navigationController = navigationController
        return navigationController
    }
    
    // MARK: - Life Cycle
    
    init(parentCoordinator: InfoLocationCoordinatorProtocol, parentController: InfoFilterButtonDelegate) {
        self.parentCoordinator = parentCoordinator
        self.parentController = parentController
    }
}

// MARK: - CoordinatorProtocol

extension InfoFilterLocationCoordinator: CoordinatorProtocol {
     func start() -> UIViewController {
        createNavigationController()
    }
    
    private func switchToNextFlow() {
        
    }

}




