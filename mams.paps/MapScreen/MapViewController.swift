

import UIKit
import YandexMapsMobile


final class MapViewController: UIViewController {
    
    private enum Const {
        static let point = YMKPoint(latitude: 55.751280, longitude: 37.629720)
        static let cameraPosition = YMKCameraPosition(target: point, zoom: 17.0, azimuth: 150.0, tilt: 30.0)
    }
        
    private lazy var mapView: YMKMapView = MapView().mapView
    private var map: YMKMap!
    
    private lazy var mapObjectTapListener: YMKMapObjectTapListener = MapObjectTapListener(controller: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        move()
        addPlacemark()
    }
    
    static func isM1Simulator() -> Bool {
        return (TARGET_IPHONE_SIMULATOR & TARGET_CPU_ARM64) != 0
    }
    
    private func setupView() {
        view = mapView
        map = mapView.mapWindow.map
    }
    
    private func move(to cameraPosition: YMKCameraPosition = Const.cameraPosition) {
        map.move(with: cameraPosition, animation: YMKAnimation(type: .smooth, duration: 1.0))
    }
    
    private func addPlacemark() {
        let image = UIImage(systemName: "circle.fill")!
        let placemark = map.mapObjects.addPlacemark()
        placemark.geometry = Const.point
        placemark.setIconWith(image)

        // Add text with style to the placemark

        placemark.setTextWithText(
            "Sample placemark",
            style: YMKTextStyle(
                size: 10.0,
                color: .black,
                outlineColor: .white,
                placement: .top,
                offset: 0.0,
                offsetFromIcon: true,
                textOptional: false
            )
        )

        // Make placemark draggable

        placemark.isDraggable = true

        // Add placemark tap handler

        placemark.addTapListener(with: mapObjectTapListener)
    }
    
    final private class MapObjectTapListener: NSObject, YMKMapObjectTapListener {
        func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
            return true
        }
        
        private weak var controller: UIViewController?
        
        init(controller: UIViewController) {
            self.controller = controller
        }
    }
}
