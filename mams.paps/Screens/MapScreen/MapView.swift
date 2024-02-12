

import Combine
import UIKit
import YandexMapsMobile

final class MapView: UIView {
    
    private enum Constants {
        static let buttonSize: CGFloat = 60
        static let buttonMargin: CGFloat = 20.0
        static let zoomButtonCornerRadius: CGFloat = 14.0
        static let circleButtonCornerRadius: CGFloat = buttonSize/2
        static let buttonColor: UIColor = UIColor.systemGray4.withAlphaComponent(0.6)
        static let buttonTintColor: UIColor = .black
        static let buttonSymbolPointSize: CGFloat = 24
        static let paddingBetweenButtonsContainer: CGFloat = 60
    }
    
    private enum defaultPosition {
        static let startPoint = YMKPoint(
            latitude: 54.707590,
            longitude: 20.508898
        )
        
        static let startPosition = YMKCameraPosition(
            target: startPoint,
            zoom: 15.0,
            azimuth: .zero,
            tilt: .zero
        )
    }
    
    // MARK: - Private properties
    private var controller: MapViewController
    
    private var searchBarController: UISearchController?
    private var mapView: YMKMapView?
    var map: YMKMap?
    private var placemark: YMKPlacemarkMapObject?
    
    /// Handles geo objects taps
    /// - Note: This should be declared as property to store a strong reference
    private var geoObjectTapListener: GeoObjectTapListener?
    
    /// Handles map inputs
    /// - Note: This should be declared as property to store a strong reference
    private var inputListener: InputListener?
    
//    private lazy var searchBar: UISearchBar = {
//        let searchBar = UISearchBar()
//        searchBar.delegate = controller
//        searchBar.searchBarStyle = .minimal
//        searchBar.searchTextField.backgroundColor = .white
//        searchBar.placeholder = "SearchBar.Placeholder".localized
//        return searchBar
//    }()
    
    private lazy var zoomButtonsContainer: UIStackView = {
        let zoomButtonsContainer = UIStackView()
        zoomButtonsContainer.axis = .vertical
        zoomButtonsContainer.spacing = Constants.buttonMargin
        zoomButtonsContainer.addArrangedSubview(plusZoomButton)
        zoomButtonsContainer.addArrangedSubview(minusZoomButton)
        return zoomButtonsContainer
    }()
    
    private lazy var circleButtonsContainer: UIStackView = {
        let circleButtonsContainer = UIStackView()
        circleButtonsContainer.axis = .vertical
        circleButtonsContainer.spacing = Constants.buttonMargin
        circleButtonsContainer.addArrangedSubview(moveToPlacemarkButton)
        circleButtonsContainer.addArrangedSubview(favoritesButton)
        return circleButtonsContainer
    }()
    
    private lazy var plusZoomButton = CustomMapsButton(
        image: UIImage(systemName: "plus"), 
        isRound: false,
        action: { [weak self] in
            self?.zoomIn()
    })
        
    private lazy var minusZoomButton = CustomMapsButton(
        image: UIImage(systemName: "minus"),
        isRound: false,
        action: { [weak self] in
            self?.zoomOut()
    })
    
    private lazy var moveToPlacemarkButton = CustomMapsButton(
        image: UIImage(systemName: "location.fill"), 
        isRound: true,
        action: { [weak self] in
            self?.moveToPlacemark()
    })
    
    private lazy var favoritesButton = CustomMapsButton(
        image: UIImage(systemName: "bookmark.fill"), 
        isRound: true,
        action: { [weak self] in
            self?.addToFavorites()
    })
    
    // MARK: - Life Cycle
    init(frame: CGRect, controller: MapViewController) {
        self.controller = controller
        super.init(frame: frame)
        setupView()
        updateMapFocus()
        addPlacemark()
        setupMapHandlers()
        move()
        setupConstraints()
        setupSearchController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: - Private methods
    private func setupView() {
        mapView = YMKMapView(frame: frame)
        addSubview(mapView ?? YMKMapView(frame: frame))
        map = mapView?.mapWindow.map
        addSubviews(
            zoomButtonsContainer,
            circleButtonsContainer,
            translatesAutoresizingMaskIntoConstraints: false
        )
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            zoomButtonsContainer.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                       constant: -Constants.buttonMargin),
            zoomButtonsContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            circleButtonsContainer.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                       constant: -Constants.buttonMargin),
            circleButtonsContainer.topAnchor.constraint(equalTo: zoomButtonsContainer.bottomAnchor,
                                                        constant: Constants.paddingBetweenButtonsContainer),
            
            plusZoomButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize),
            plusZoomButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize),
            
            minusZoomButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize),
            minusZoomButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize),
            
            moveToPlacemarkButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize),
            moveToPlacemarkButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize),
            
            favoritesButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize),
            favoritesButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize),
            
        ])
    }
    
    private func setupMapHandlers() {
        guard let map else { return }
        let geoObjectTapListener = GeoObjectTapListener(map: map, controller: controller)
        self.geoObjectTapListener = geoObjectTapListener
        map.addTapListener(with: geoObjectTapListener)
    }
    
    private func addPlacemark() {
        guard let map else { return }
        
        let placemark = map.mapObjects.addPlacemark()
        
        if let currentLocation = controller.currentLocation {
            placemark.geometry = YMKPoint(
                latitude: currentLocation.latitude,
                longitude: currentLocation.longitude
            )
        } else {
            placemark.geometry = defaultPosition.startPoint
        }
        
        if let image = UIImage(named: "placemark") {
            placemark.setIconWith(image)
        }
        placemark.isDraggable = true
        self.placemark = placemark
      
        let inputListener = InputListener(placemark: placemark)
        self.inputListener = inputListener
        
        map.addInputListener(with: inputListener)
    }
    
    private func updateMapFocus() {
        guard let mapView else { return }
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
    private func move(to cameraPosition: YMKCameraPosition) {
        guard let map else { return }
        map.move(with: cameraPosition, animation: YMKAnimation(type: .smooth, duration: 1.0))
    }

    func move() {
        let targetLatitude = controller.currentLocation?.latitude
        let targetLongitude = controller.currentLocation?.longitude
        
        let cameraPosition = YMKCameraPosition(
            target: YMKPoint(latitude: targetLatitude ?? defaultPosition.startPoint.latitude, 
                             longitude: targetLongitude ?? defaultPosition.startPoint.longitude),
            zoom: 15.0,
            azimuth: .zero,
            tilt: .zero
        )
        move(to: cameraPosition)
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
    
    private func setupSearchController() {
        searchBarController = UISearchController()
        searchBarController?.searchResultsUpdater = controller
        searchBarController?.obscuresBackgroundDuringPresentation = true
        searchBarController?.hidesNavigationBarDuringPresentation = false
        searchBarController?.delegate = controller
        controller.definesPresentationContext = true

        if let searchBar = searchBarController?.searchBar {
            searchBar.placeholder = "SearchBar.Placeholder".localized
            searchBar.searchBarStyle = .minimal
            searchBar.showsBookmarkButton = false
            searchBar.delegate = controller
            addSubview(searchBar)
            
//            searchBar.translatesAutoresizingMaskIntoConstraints = false
//            
//            NSLayoutConstraint.activate([
//                searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,
//                                               constant: 20),
//                searchBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
//                                               constant: 20),
//                searchBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
//                                               constant: -20),
//            ])
        }
    }
    
    func getSearchController() -> UISearchController {
        guard let searchBarController else {
            return UISearchController()
        }
        return searchBarController
    }
    
    @objc private func zoomIn() {
        changeZoom(by: 1.0)
    }
    
    @objc private func zoomOut() {
        changeZoom(by: -1.0)
    }
    
    @objc private func moveToPlacemark() {
        guard let map else { return }
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
    
    @objc private func addToFavorites() {
        print("add place to favorites")
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
            guard let map = map, let _ = controller,
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
        
        private let placemark: YMKPlacemarkMapObject
        
        init(placemark: YMKPlacemarkMapObject) {
            self.placemark = placemark
        }
        
        func onMapTap(with map: YMKMap, point: YMKPoint) {}
        
        func onMapLongTap(with map: YMKMap, point: YMKPoint) {
            placemark.geometry = point
        }
    }
    
    final private class CustomMapsButton: UIButton {
        private var customAction: (() -> Void)?

        init(image: UIImage?, isRound: Bool, action: (() -> Void)?) {
            super.init(frame: .zero)
            self.customAction = action
            commonInit()
            setImage(image, for: .normal)
            setupStyle(isRound: isRound)
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
            commonInit()
        }

        private func commonInit() {
            addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        }

        @objc private func buttonTapped() {
            customAction?()
        }

        private func setupStyle(isRound: Bool) {
            let configuration = UIImage.SymbolConfiguration(
                pointSize: Constants.buttonSymbolPointSize,
                weight: .regular
            )
            
            if isRound {
                layer.cornerRadius = Constants.circleButtonCornerRadius
            } else {
                layer.cornerRadius = Constants.zoomButtonCornerRadius
            }
            setPreferredSymbolConfiguration(configuration, 
                                            forImageIn: .normal
            )
            backgroundColor = Constants.buttonColor
            tintColor = Constants.buttonTintColor
        }
    }
}
