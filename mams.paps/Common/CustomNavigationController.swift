//
//  CustomNavigationController.swift
//  mams.paps
//
//  Created by Юлия Кагирова on 21.02.2024.
//

import UIKit

extension UIViewController {
    func createCustomNavBar(on viewController: UIViewController,title: String) -> UINavigationController {
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(
            title: title,
            style: .done,
            target: self,
            action: nil)
        navigationController?.navigationBar.barTintColor = .customGrey
        return UINavigationController()
    }
}
