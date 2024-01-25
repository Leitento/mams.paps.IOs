

import UIKit
import YandexMapsMobile

protocol MapViewControllerDelegate: AnyObject {
    
}

final class MapViewController: UIViewController, MapViewControllerDelegate {
    
    // MARK: - Properties
    lazy var mapView = MapView(frame: view.bounds, controller: self)
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
      
    }

    // MARK: - Private methods

}
