//
//  NotificationViewController.swift
//  mams.paps
//
//  Created by Юлия Кагирова on 17.02.2024.
//

import UIKit

final class NotificationViewController: UIViewController {
    
    //MARK: - Properties
    
    weak var profileCoordinator: ProfileScreenCoordinator?
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = .white
        setCustomBackBarItem(title: "Notification.navBar".localized)

    }

    
}
