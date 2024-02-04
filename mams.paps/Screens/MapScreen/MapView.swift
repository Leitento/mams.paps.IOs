

import UIKit
import YandexMapsMobile

final class MapView: UIView {
    
    private enum Constants {
        static let buttonSize: CGFloat = 48.0
        static let buttonMargin: CGFloat = 16.0
        static let buttonCornerRadius: CGFloat = 8.0
        static let buttonColor: UIColor = UIColor.white.withAlphaComponent(0.9)
    }
    
    private enum Position {
        static let startPoint = YMKPoint(latitude: 54.707590, longitude: 20.508898)
        
        static let startPosition = YMKCameraPosition(
            target: startPoint,
            zoom: 15.0,
            azimuth: .zero,
            tilt: .zero
        )
    }
    
    var controller: MapViewController
    
    private var mapView: YMKMapView!
    private var map: YMKMap!
    private var placemark: YMKPlacemarkMapObject?
    
    /// Handles geo objects taps
    /// - Note: This should be declared as property to store a strong reference
    private var geoObjectTapListener: GeoObjectTapListener?
    
    /// Handles map inputs
    /// - Note: This should be declared as property to store a strong reference
    private var inputListener: InputListener?
    
    private lazy var buttonsContainer: UIStackView = {
        let buttonsContainer = UIStackView()
        buttonsContainer.translatesAutoresizingMaskIntoConstraints =  false
        buttonsContainer.axis = .vertical
        buttonsContainer.spacing = Constants.buttonMargin
        buttonsContainer.addArrangedSubview(plusZoomButton)
        buttonsContainer.addArrangedSubview(minusZoomButton)
        buttonsContainer.addArrangedSubview(moveToPlacemarkButton)
        return buttonsContainer
    }()
    
    private lazy var plusZoomButton: UIButton = {
        let plusZoomButton = UIButton()
        plusZoomButton.translatesAutoresizingMaskIntoConstraints = false
        plusZoomButton.setImage(UIImage(systemName: "plus"), for: .normal)
        plusZoomButton.addTarget(self, action: #selector(zoomIn), for: .touchUpInside)
        plusZoomButton.layer.cornerRadius = Constants.buttonCornerRadius
        plusZoomButton.backgroundColor = Constants.buttonColor
        return plusZoomButton
    }()
    
    private lazy var minusZoomButton: UIButton = {
        let minusZoomButton = UIButton()
        minusZoomButton.translatesAutoresizingMaskIntoConstraints = false
        minusZoomButton.setImage(UIImage(systemName: "minus"), for: .normal)
        minusZoomButton.addTarget(self, action: #selector(zoomOut), for: .touchUpInside)
        minusZoomButton.layer.cornerRadius = Constants.buttonCornerRadius
        minusZoomButton.backgroundColor = Constants.buttonColor
        return minusZoomButton
    }()
    
    private lazy var moveToPlacemarkButton: UIButton = {
        let moveToPlacemarkButton = UIButton()
        moveToPlacemarkButton.translatesAutoresizingMaskIntoConstraints = false
        moveToPlacemarkButton.setImage(UIImage(systemName: "location.fill"), for: .normal)
        moveToPlacemarkButton.addTarget(self, action: #selector(moveToPlacemark), for: .touchUpInside)
        moveToPlacemarkButton.layer.cornerRadius = Constants.buttonCornerRadius
        moveToPlacemarkButton.backgroundColor = Constants.buttonColor
        return moveToPlacemarkButton
    }()
    
    
    // Create new map view
    private func setupMapView() {
        mapView = YMKMapView(frame: frame)
        addSubview(mapView)
        map = mapView.mapWindow.map
    }
    
    private func addSubviews() {
        addSubview(buttonsContainer)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            buttonsContainer.trailingAnchor.constraint(equalTo: trailingAnchor, 
                                                       constant: -Constants.buttonMargin),
            buttonsContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
            buttonsContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            plusZoomButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize),
            plusZoomButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize),
            
            minusZoomButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize),
            minusZoomButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize),
            
            moveToPlacemarkButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize),
            moveToPlacemarkButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize),
            
        ])
    }
    
    private func setupMapHandlers() {
        let geoObjectTapListener = GeoObjectTapListener(map: map, controller: controller)
        self.geoObjectTapListener = geoObjectTapListener
        map.addTapListener(with: geoObjectTapListener)
    }
    
    private func addPlacemark() {
        let image = UIImage(named: "placemark")!
        let placemark = map.mapObjects.addPlacemark()
        placemark.geometry = Position.startPoint
        placemark.setIconWith(image)
        
        self.placemark = placemark
        
        // Make placemark draggable
        
        placemark.isDraggable = true
        
        // Add map listener
        
        let inputListener = InputListener(placemark: placemark)
        self.inputListener = inputListener
        
        map.addInputListener(with: inputListener)
    }
    
    private func updateMapFocus() {
        let scale = Float(UIScreen.main.scale)
        
        mapView.mapWindow.focusRect = YMKScreenRect(
            topLeft: YMKScreenPoint(x: 0.0, y: 0.0),
            bottomRight: YMKScreenPoint(
                x: Float(frame.width - (Constants.buttonSize + Constants.buttonMargin)) * scale,
                y: Float(frame.height) * scale
            )
        )
        
        mapView.mapWindow.focusPoint = YMKScreenPoint(
            x: Float(frame.midX - (Constants.buttonSize + Constants.buttonMargin) / 2) * scale,
            y: Float(frame.midY) * scale
        )
    }
    
    /// Sets the map to specified point, zoom, azimuth and tilt
    private func move(to cameraPosition: YMKCameraPosition = Position.startPosition) {
        map.move(with: cameraPosition, animation: YMKAnimation(type: .smooth, duration: 1.0))
    }
    
    private func changeZoom(by amount: Float) {
        guard let map = map else {
            return
        }
        map.move(
            with: YMKCameraPosition(
                target: map.cameraPosition.target,
                zoom: map.cameraPosition.zoom + amount,
                azimuth: map.cameraPosition.azimuth,
                tilt: map.cameraPosition.tilt
            ),
            animation: YMKAnimation(type: .smooth, duration: 1.0)
        )
    }
    
    @objc private func zoomIn() {
        changeZoom(by: 1.0)
    }
    
    @objc private func zoomOut() {
        changeZoom(by: -1.0)
    }
    
    @objc private func moveToPlacemark() {
        if let geometry = placemark?.geometry {
            move(
                to: YMKCameraPosition(
                    target: geometry,
                    zoom: map.cameraPosition.zoom,
                    azimuth: map.cameraPosition.azimuth,
                    tilt: map.cameraPosition.tilt
                )
            )
        }
    }
    
    init(frame: CGRect, controller: MapViewController) {
        self.controller = controller
        super.init(frame: frame)
        setupMapView()
        addSubviews()
        setupConstraints()
        updateMapFocus()
        addPlacemark()
        setupMapHandlers()
        move()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private nesting
    
    /// Handles geoobjects taps
    final private class GeoObjectTapListener: NSObject, YMKLayersGeoObjectTapListener {
        
        private weak var map: YMKMap?
        private weak var controller: UIViewController?
        
        init(map: YMKMap, controller: UIViewController) {
            self.map = map
            self.controller = controller
        }
        
        func onObjectTap(with event: YMKGeoObjectTapEvent) -> Bool {
            guard let map = map, let controller = controller,
                  let point = event.geoObject.geometry.first?.point else {
                return true
            }
            
            let cameraPosition = map.cameraPosition
            map.move(
                with: YMKCameraPosition(
                    target: point,
                    zoom: cameraPosition.zoom,
                    azimuth: cameraPosition.azimuth,
                    tilt: cameraPosition.tilt
                ),
                animation: YMKAnimation(type: .smooth, duration: 1.0)
            )
            return true
        }
    }
    
    /// Handles map inputs
    final private class InputListener: NSObject, YMKMapInputListener {
        init(placemark: YMKPlacemarkMapObject) {
            self.placemark = placemark
        }
        
        func onMapTap(with map: YMKMap, point: YMKPoint) {}
        
        func onMapLongTap(with map: YMKMap, point: YMKPoint) {
            placemark.geometry = point
        }
        
        private let placemark: YMKPlacemarkMapObject
    }
}
