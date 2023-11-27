

import UIKit

protocol CoordinatorProtocol: AnyObject {
    
    var childCoordinators: [CoordinatorProtocol] { get set }
    
    func start() -> UIViewController
    func showNextScreen()
    
    func addChildCoordinator(_ coordinator: CoordinatorProtocol)
    func removeChildCoordinator(_ coordinator: CoordinatorProtocol)
    
}

extension CoordinatorProtocol {
    func addChildCoordinator(_ coordinator: CoordinatorProtocol) {
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: CoordinatorProtocol) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
}
