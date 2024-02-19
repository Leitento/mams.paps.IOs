//
//  ContractOfferCoordinator.swift
//  mams.paps
//
//  Created by Юлия Кагирова on 19.02.2024.
//

import UIKit

final class ContractOfferCoordinator: CoordinatorProtocol {
    func start() -> UIViewController {
        return UIViewController()
    }
    
    
    // MARK: - Private Properties
    
//    private weak var parentCoordinator: TabBarCoordinatorProtocol?
    private var childCoordinators: [CoordinatorProtocol] = []
    weak var parentCoordinator: ProfileScreenCoordinator?
//    private var rootViewController: UIViewController?
    private var navigationController: UINavigationController //?
    
    // MARK: - Life Cycle
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Private methods
    
    func start() {
        let vc = ContractOfferViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
