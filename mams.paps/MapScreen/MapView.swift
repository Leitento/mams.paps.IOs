

import UIKit
import YandexMapsMobile

final class MapView: UIView {
    
    
    var controller: MapViewController

  
    init(frame: CGRect, controller: MapViewController) {
        self.controller = controller
        super.init(frame: frame)
        mapView = YMKMapView(frame: frame)
        addSubview(mapView)


        setupSubviews()


        updateMapFocus()


        map = mapView.mapWindow.map


        move()

        // Setup map handlers

        let geoObjectTapListener = GeoObjectTapListener(map: map, controller: controller)
        self.geoObjectTapListener = geoObjectTapListener

        map.addTapListener(with: geoObjectTapListener)

        // Add placemark

        addPlacemark()

        // Add polyline

//        addPolyline()

        // Add buttons handlers

        plusZoomButton.addTarget(self, action: #selector(zoomIn), for: .touchUpInside)
        minusZoomButton.addTarget(self, action: #selector(zoomOut), for: .touchUpInside)
        moveToPlacemarkButton.addTarget(self, action: #selector(moveToPlacemark), for: .touchUpInside)
        moveToPolylineButton.addTarget(self, action: #selector(moveToPolyline), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Sets the map to specified point, zoom, azimuth and tilt
    private func move(to cameraPosition: YMKCameraPosition = Const.startPosition) {
        map.move(with: cameraPosition, animation: YMKAnimation(type: .smooth, duration: 1.0))
    }

    /// Sets the map to specified geometry
    private func move(to geometry: YMKGeometry) {
        let cameraPosition = map.cameraPosition(with: geometry)

        map.move(with: cameraPosition, animation: YMKAnimation(type: .smooth, duration: 1.0))
    }

    /// Updates map focus
    private func updateMapFocus() {
        let scale = Float(UIScreen.main.scale)

        mapView.mapWindow.focusRect = YMKScreenRect(
            topLeft: YMKScreenPoint(x: 0.0, y: 0.0),
            bottomRight: YMKScreenPoint(
                x: Float(frame.width - (Layout.buttonSize + Layout.buttonMargin)) * scale,
                y: Float(frame.height) * scale
            )
        )

        mapView.mapWindow.focusPoint = YMKScreenPoint(
            x: Float(frame.midX - (Layout.buttonSize + Layout.buttonMargin) / 2) * scale,
            y: Float(frame.midY) * scale
        )
    }

    /// Zooms in the map by one step
    @objc
    private func zoomIn() {
        changeZoom(by: 1.0)
    }

    /// Zooms out the map by one step
    @objc
    private func zoomOut() {
        changeZoom(by: -1.0)
    }

    /// Changes the map's zoom by the given amount
    /// - Parameter amount: The amount to change the map's zoom by
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

    @objc
    private func moveToPlacemark() {
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

    @objc
    private func moveToPolyline() {
        if let polyline = polyline {
            move(to: YMKGeometry(polyline: polyline))
        }
    }

    /// Adds a placemark to the map
    private func addPlacemark() {
        let image = UIImage(systemName: "circle.fill")!
        let placemark = map.mapObjects.addPlacemark()
        placemark.geometry = Const.startPoint
        placemark.setIconWith(image)

        self.placemark = placemark

        // Make placemark draggable

        placemark.isDraggable = true

        // Add map listener

        let inputListener = InputListener(placemark: placemark)
        self.inputListener = inputListener

        map.addInputListener(with: inputListener)
    }

    /// Adds a polyline to the map
    private func addPolyline() {
        let polyline = YMKPolyline(points: Const.polylinePoints)
        self.polyline = polyline

        map.mapObjects.addPolyline(with: polyline)
    }

    // MARK: - Private properties

    private let buttonsContainer = UIStackView()
    private let plusZoomButton = UIButton()
    private let minusZoomButton = UIButton()
    private let moveToPlacemarkButton = UIButton()
    private let moveToPolylineButton = UIButton()

    private var mapView: YMKMapView!
    private var map: YMKMap!
    private var placemark: YMKPlacemarkMapObject?
    private var polyline: YMKPolyline?

    /// Handles geo objects taps
    /// - Note: This should be declared as property to store a strong reference
    private var geoObjectTapListener: GeoObjectTapListener?

    /// Handles map inputs
    /// - Note: This should be declared as property to store a strong reference
    private var inputListener: InputListener?

    // MARK: - Private nesting

    /// Handles geoobjects taps
    final private class GeoObjectTapListener: NSObject, YMKLayersGeoObjectTapListener {
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

            let name = event.geoObject.name ?? "Unnamed geoObject"

//            AlertPresenter.present(
//                from: controller,
//                with: "Tapped \(name)",
//                message: "\((point.latitude, point.longitude))"
//            )

            return true
        }

        init(map: YMKMap, controller: UIViewController) {
            self.map = map
            self.controller = controller
        }

        private weak var map: YMKMap?
        private weak var controller: UIViewController?
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

    private enum Const {
        static let startPoint = YMKPoint(latitude: 54.707590, longitude: 20.508898)

        static let startPosition = YMKCameraPosition(
            target: startPoint,
            zoom: 15.0,
            azimuth: .zero,
            tilt: .zero
        )

        static let polylinePoints = [
            YMKPoint(latitude: 54.701079, longitude: 20.513011),
            YMKPoint(latitude: 54.702409, longitude: 20.505102),
            YMKPoint(latitude: 54.709270, longitude: 20.508272),
            YMKPoint(latitude: 54.708539, longitude: 20.514920),
            YMKPoint(latitude: 54.705865, longitude: 20.514524),
            YMKPoint(latitude: 54.706133, longitude: 20.511160)
        ]
    }

    // MARK: - Layout

    private enum Layout {
        static let buttonSize: CGFloat = 48.0
        static let buttonMargin: CGFloat = 16.0
        static let buttonCornerRadius: CGFloat = 8.0
    }

    /// Setups buttons layout
    private func setupSubviews() {
        addSubview(buttonsContainer)
        buttonsContainer.translatesAutoresizingMaskIntoConstraints = false

        buttonsContainer.spacing = Layout.buttonMargin
        buttonsContainer.axis = .vertical

        [
            buttonsContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Layout.buttonMargin),
            buttonsContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
            buttonsContainer.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        .forEach { $0.isActive = true }

        [plusZoomButton, minusZoomButton, moveToPlacemarkButton, moveToPolylineButton].forEach {
            buttonsContainer.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.backgroundColor = .systemBackground
            $0.layer.cornerRadius = Layout.buttonCornerRadius

            [
                $0.widthAnchor.constraint(equalToConstant: Layout.buttonSize),
                $0.heightAnchor.constraint(equalToConstant: Layout.buttonSize)
            ]
            .forEach { $0.isActive = true }
        }

        plusZoomButton.setImage(UIImage(systemName: "plus"), for: .normal)
        minusZoomButton.setImage(UIImage(systemName: "minus"), for: .normal)
        moveToPlacemarkButton.setImage(UIImage(systemName: "mappin.and.ellipse"), for: .normal)
        moveToPolylineButton.setImage(UIImage(systemName: "hexagon"), for: .normal)
    }
    
}

//
//
//import UIKit
//import YandexMapsMobile
//
//protocol MapViewProtocol: AnyObject {
//    
//}
//
//final class MapView: UIView {
//    
//    private enum Constants {
//        static let buttonSize: CGFloat = 48.0
//        static let buttonMargin: CGFloat = 16.0
//        static let buttonCornerRadius: CGFloat = 8.0
//    }
//    
//    @objc public var mapView: YMKMapView!
//    
//    private var map: YMKMap?
//    
//    private lazy var buttonsContainer: UIStackView = {
//        let buttonsContainer = UIStackView()
//        buttonsContainer.translatesAutoresizingMaskIntoConstraints =  false
//        buttonsContainer.axis = .vertical
//        buttonsContainer.spacing = Constants.buttonMargin
//        buttonsContainer.addArrangedSubview(plusZoomButton)
//        buttonsContainer.addArrangedSubview(minusZoomButton)
//        return buttonsContainer
//    }()
//    
//    private let plusZoomButton: UIButton = {
//        let plusZoomButton = UIButton()
//        plusZoomButton.translatesAutoresizingMaskIntoConstraints = false
//        plusZoomButton.setImage(UIImage(systemName: "plus"), for: .normal)
//        plusZoomButton.addTarget(MapView.self, action: #selector(zoomIn), for: .touchUpInside)
//        plusZoomButton.layer.cornerRadius = Constants.buttonCornerRadius
//        plusZoomButton.backgroundColor = .systemGray
//        return plusZoomButton
//    }()
//    
//    private let minusZoomButton: UIButton = {
//        let minusZoomButton = UIButton()
//        minusZoomButton.translatesAutoresizingMaskIntoConstraints = false
//        minusZoomButton.setImage(UIImage(systemName: "minus"), for: .normal)
//        minusZoomButton.addTarget(MapView.self, action: #selector(zoomOut), for: .touchUpInside)
//        minusZoomButton.layer.cornerRadius = Constants.buttonCornerRadius
//        minusZoomButton.backgroundColor = .systemGray
//        return minusZoomButton
//    }()
//    
////    override init(frame: CGRect, scaleFactor: Float, vulkanPreferred: Bool, lifecycleProvider: YRTLifecycleProvider?) {
////        super.init(frame: frame, scaleFactor: scaleFactor, vulkanPreferred: vulkanPreferred, lifecycleProvider: lifecycleProvider)
////        addSubviews()
////        setupConstraints()
////        mapWindow.map.mapType = .map
////    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setup()
//        addSubviews()
//        setupConstraints()
//    }
//        
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setup() {
//        mapView = YMKMapView(frame: bounds, vulkanPreferred: MapView.isM1Simulator())
//        mapView.mapWindow.map.mapType = .map
//    }
//    
//    private func addSubviews() {
//        addSubview(buttonsContainer)
//    }
//        
//    private func setupConstraints() {
//        NSLayoutConstraint.activate([
//            buttonsContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.buttonMargin),
//            buttonsContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
//            buttonsContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
//            
//            plusZoomButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize),
//            plusZoomButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize),
//            
//            minusZoomButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize),
//            minusZoomButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize),
//            
//        ])
//    }
//    
//    private func changeZoom(by amount: Float) {
//        guard let map = map else {
//            return
//        }
//        map.move(
//            with: YMKCameraPosition(
//                target: map.cameraPosition.target,
//                zoom: map.cameraPosition.zoom + amount,
//                azimuth: map.cameraPosition.azimuth,
//                tilt: map.cameraPosition.tilt
//            ),
//            animation: YMKAnimation(type: .smooth, duration: 1.0)
//        )
//    }
//    
//    static func isM1Simulator() -> Bool {
//        return (TARGET_IPHONE_SIMULATOR & TARGET_CPU_ARM64) != 0
//    }
//    
//    @objc
//    private func zoomIn() {
//        changeZoom(by: 1.0)
//    }
//
//    @objc
//    private func zoomOut() {
//        changeZoom(by: -1.0)
//    }
//}
