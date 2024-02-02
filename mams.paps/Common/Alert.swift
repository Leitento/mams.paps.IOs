

import UIKit

final class Alert {
    
    static let shared = Alert()
    
    init() {}
    
    func showAlert(
        on viewController: UIViewController,
        title: String,
        message: String?,
        completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion?()
        }))
        viewController.present(alert, animated: true, completion: nil)
    }
    func showAlertAction(
        on viewController: UIViewController,
        title: String,
        message: String?,
        completion: (() -> Void)? = nil) {
        let alertPhotoEdit = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let addPhoto = UIAlertAction(title: "Добавить фото", style: .default) { _ in
            print("add photo")
        }
        alertPhotoEdit.addAction(addPhoto)

        let editPhoto = UIAlertAction(title: "Изменить фото", style: .default) { _ in
            print("edit photo")
        }
        alertPhotoEdit.addAction(editPhoto)

        let deletePhoto = UIAlertAction(title: "Удалить фото", style: .destructive) { _ in
            print("delete photo")
        }
        alertPhotoEdit.addAction(deletePhoto)

        let cancel = UIAlertAction(title: "Отмена", style: .cancel) { _ in
            print("cancel")
        }
        alertPhotoEdit.addAction(cancel)
        
        ProfileEditScreenController().present(alertPhotoEdit, animated: true, completion: nil)

    }
}
