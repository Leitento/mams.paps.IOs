

import UIKit
import PhotosUI

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
    
    func photoEditAlert(viewController: UIViewController, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let addPhoto = UIAlertAction(title: "ProfilePhotoEditAlert.addphoto".localized, style: .default) { _ in
            PHPhotoLibrary.requestAuthorization { status in
                if status == .authorized {
                    completion?()
                } else {
                    return
                }
            }
        }
        let editPhoto = UIAlertAction(title: "ProfilePhotoEditAlert.edit".localized, style: .default) { _ in
            print("edit photo")
        }
        let deletePhoto = UIAlertAction(title: "ProfilePhotoEditAlert.delete".localized, style: .destructive) { _ in
            print("delete photo")
        }
        let cancel = UIAlertAction(title: "ProfilePhotoEditAlert.cancel".localized, style: .cancel) { _ in
            print("cancel")
        }
        alert.addAction(addPhoto)
        alert.addAction(editPhoto)
        alert.addAction(deletePhoto)
        alert.addAction(cancel)
        viewController.present(alert, animated: true)
    }
    func alertError(viewController: UIViewController, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let alertError = UIAlertAction(title: "ProfilePhotoEditAlert.error".localized, style: .default) { _ in
            print("alert error")
        }
        alert.addAction(alertError)
        viewController.present(alert, animated: true)
    }
}
