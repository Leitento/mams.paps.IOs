//
//  MapViewController.swift
//  MapInteraction
//

import UIKit
import YandexMapsMobile

protocol YandexMapViewControllerDelegate: AnyObject {
    
}

class YandexMapViewController: UIViewController, YandexMapViewControllerDelegate {
    // MARK: - Public methods

    lazy var mapView = TestMapView(frame: view.bounds, controller: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mapView)
        // Create new map view
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
      
    }

    // MARK: - Private methods

}
