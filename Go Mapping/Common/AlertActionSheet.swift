

import UIKit

final class AlertActionSheet {
    
    static let shared = AlertActionSheet()
    
    init() {}
    
    func showAlertActionSheet(on viewController: UIViewController, title: String, message: String?, completion: (() -> Void)? = nil) {
        let alert  = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let titleFont = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20 , weight: .regular)]
        
        alert.title = title
        
        let addFavorites = UIAlertAction(title: "Добавить в избранное", style: .default) { _ in
            print("Добавить в избранное")
        }
        let share = UIAlertAction(title: "Поделиться", style: .default) { _ in
            print("Поделиться")
        }
        let hide = UIAlertAction(title: "Скрыть", style: .default) { _ in
            print("Скрыть")
        }
        let cancel = UIAlertAction(title: "Отмена", style: .cancel) { _ in
            print("Отмена")
        }
        
        alert.setValue(NSAttributedString(string: title, attributes: titleFont), forKey: "attributedTitle")
        cancel.setValue(UIColor.customRed, forKey: "titleTextColor")
        alert.addAction(addFavorites)
        alert.addAction(share)
        alert.addAction(hide)
        alert.addAction(cancel)

        viewController.present(alert, animated: true, completion: nil)
    }
}
