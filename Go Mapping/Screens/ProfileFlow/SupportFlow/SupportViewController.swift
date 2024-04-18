//
//  SupportViewController.swift
//  mams.paps
//
//  Created by Юлия Кагирова on 17.02.2024.
//

import UIKit

final class SupportViewController: UIViewController {
    
    //MARK: - Properties
    
    weak var profileCoordinator: ProfileScreenCoordinator?
    
    //MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - Private Methods
    
   private func setupUI() {
        view.backgroundColor = .white
       setCustomBackBarItem(title: "Support.navBar".localized)
    }
}
