

import UIKit
import YandexMapsMobile

final class MapView: UIView {
    
    private enum Constants {
        static let buttonSize: CGFloat = 60
        static let padding: CGFloat = 20.0
        static let searchBarHeight: CGFloat = 50.0
        static let filterButtonHeight: CGFloat = 50
        static let filterButtonWidth: CGFloat = 150
        static let barButtonsCornerRadius: CGFloat = 24.0
        static let zoomButtonCornerRadius: CGFloat = 14.0
        static let circleButtonCornerRadius: CGFloat = buttonSize/2
        static let buttonSymbolPointSize: CGFloat = 24
        static let paddingBetweenButtonsContainer: CGFloat = 60
        static let placeholderColor: UIColor = .gray.withAlphaComponent(0.6)
        static let buttonColor: UIColor = UIColor.gray.withAlphaComponent(0.2)
        static let buttonTintColor: UIColor = .black
        static let filterButtonBackgroundColor: UIColor = UIColor(named: "darkBlue") ?? .systemBlue
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
    
    private var mapView: YMKMapView?
    var map: YMKMap?
    private var placemark: YMKPlacemarkMapObject?
    
    /// Handles geo objects taps
    /// - Note: This should be declared as property to store a strong reference
    private var geoObjectTapListener: GeoObjectTapListener?
    
    /// Handles map inputs
    /// - Note: This should be declared as property to store a strong reference
    private var inputListener: InputListener?
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
        searchBar.backgroundColor = .white
        searchBar.layer.cornerRadius = Constants.barButtonsCornerRadius
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.black.cgColor
        searchBar.searchTextField.borderStyle = .none
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.font = .systemFont(
            ofSize: 17,
            weight: .regular)
        searchBar.searchTextField.textColor = .black
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "SearchBar.Placeholder".localized,
            attributes: [NSAttributedString.Key.foregroundColor: Constants.placeholderColor])
        searchBar.showsBookmarkButton = true
        searchBar.setImage(
            UIImage(systemName: "magnifyingglass",
                    withConfiguration: UIImage.SymbolConfiguration(
                        pointSize: 17,
                        weight: .regular))?
                .withTintColor(Constants.placeholderColor,
                               renderingMode: .alwaysOriginal),
            for: .search,
            state: .normal)
        searchBar.setImage(
            UIImage(systemName: "mic.fill",
                    withConfiguration: UIImage.SymbolConfiguration(
                        pointSize: 17,
                        weight: .regular))?
                .withTintColor(Constants.placeholderColor,
                               renderingMode: .alwaysOriginal),
            for: .bookmark,
            state: .normal)
        searchBar.setImage(
            UIImage(systemName: "xmark.circle.fill",
                    withConfiguration: UIImage.SymbolConfiguration(
                        pointSize: 17,
                        weight: .regular))?
                .withTintColor(Constants.placeholderColor,
                               renderingMode: .alwaysOriginal),
            for: .clear,
            state: .normal)
        searchBar.tintColor = .black
        
        return searchBar
    }()
    
    private lazy var zoomButtonsContainer: UIStackView = {
        let zoomButtonsContainer = UIStackView()
        zoomButtonsContainer.axis = .vertical
        zoomButtonsContainer.spacing = Constants.padding
        zoomButtonsContainer.addArrangedSubview(plusZoomButton)
        zoomButtonsContainer.addArrangedSubview(minusZoomButton)
        return zoomButtonsContainer
    }()
    
    private lazy var circleButtonsContainer: UIStackView = {
        let circleButtonsContainer = UIStackView()
        circleButtonsContainer.axis = .vertical
        circleButtonsContainer.spacing = Constants.padding
        circleButtonsContainer.addArrangedSubview(moveToCurrentLocationButton)
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
    
    private lazy var moveToCurrentLocationButton = CustomMapsButton(
        image: UIImage(systemName: "location.fill"),
        isRound: true,
        action: { [weak self] in
            self?.moveToCurrentLocation()
        })
    
    private lazy var favoritesButton = CustomMapsButton(
        image: UIImage(systemName: "bookmark.fill"),
        isRound: true,
        action: { [weak self] in
            self?.addToFavorites()
        })
    
    private lazy var filterButton: UIButton = {
        let filterButton = UIButton(type: .custom)
        filterButton.setTitle("MapView.FilterButton".localized, for: .normal)
        filterButton.setTitleColor(.white, for: .normal)
        filterButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        filterButton.layer.cornerRadius = Constants.barButtonsCornerRadius
        filterButton.backgroundColor = Constants.filterButtonBackgroundColor
        
        let image = UIImage(systemName: "slider.horizontal.3", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular))
        filterButton.setImage(image, for: .normal)
        filterButton.tintColor = .white
        
        var buttonConfig = UIButton.Configuration.tinted()
        buttonConfig.imagePadding = Constants.padding
        buttonConfig.imagePlacement = .trailing
        filterButton.configuration = buttonConfig
        
        filterButton.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
        return filterButton
    }()
    
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
            searchBar,
            zoomButtonsContainer,
            circleButtonsContainer,
            filterButton,
            translatesAutoresizingMaskIntoConstraints: false
        )
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        addGestureRecognizer(tapGesture)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor,
                                               constant: Constants.padding),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                constant: -Constants.padding),
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,
                                           constant: Constants.padding),
            searchBar.heightAnchor.constraint(equalToConstant: Constants.searchBarHeight),
            
            zoomButtonsContainer.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                           constant: -Constants.padding),
            zoomButtonsContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            circleButtonsContainer.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                             constant: -Constants.padding),
            circleButtonsContainer.topAnchor.constraint(equalTo: zoomButtonsContainer.bottomAnchor,
                                                        constant: Constants.paddingBetweenButtonsContainer),
            
            filterButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Constants.padding),
            filterButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            filterButton.widthAnchor.constraint(equalToConstant: 200),
            filterButton.heightAnchor.constraint(equalToConstant: Constants.filterButtonHeight),
            
            plusZoomButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize),
            plusZoomButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize),
            
            minusZoomButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize),
            minusZoomButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize),
            
            moveToCurrentLocationButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize),
            moveToCurrentLocationButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize),
            
            favoritesButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize),
            favoritesButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize),
            
        ])
    }
    
    private func setupMapHandlers() {
        guard let map else { return }
        let geoObjectTapListener = GeoObjectTapListener(
            map: map,
            controller: controller)
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
                x: Float(frame.width - (Constants.buttonSize + Constants.padding)) * scale,
                y: Float(frame.height) * scale
            )
        )
        
        mapView.mapWindow.focusPoint = YMKScreenPoint(
            x: Float(frame.midX - (Constants.buttonSize + Constants.padding) / 2) * scale,
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
    
    private func animateMicrophoneButton() {
        UIView.animate(withDuration: 0.1, animations: {
            self.searchBar.searchTextField.rightView?.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.searchBar.searchTextField.rightView?.transform = .identity
            }
        }
    }
    
    private func animateSearchBar() {
        UIView.animate(withDuration: 0.1, animations: {
            self.searchBar.searchTextField.leftView?.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.searchBar.searchTextField.leftView?.transform = .identity
            }
        }
    }
    
    @objc private func zoomIn() {
        changeZoom(by: 1.0)
    }
    
    @objc private func zoomOut() {
        changeZoom(by: -1.0)
    }
    
    @objc private func moveToCurrentLocation() {
        move()
        addPlacemark()
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
        // Здесь обрабатываем нажатие на кнопку Избранное
        print("add place to favorites")
    }
    
    @objc private func filterButtonTapped(_ sender: UIButton) {
        // Здесь обрабатываем нажатие на кнопку Фильтры
        print("Filters button tapped")
    }
    
    @objc private func dismissKeyboard() {
        endEditing(true)
        searchBar.showsCancelButton = false
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
            animateTap()
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
        
        private func animateTap() {
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }) { _ in
                UIView.animate(withDuration: 0.1) {
                    self.transform = .identity
                }
            }
        }
    }
}

extension MapView: UISearchBarDelegate {
        
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        animateSearchBar()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = true
        controller.searchText(with: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        // Здесь обрабатываем нажатие на кнопку микрофона
        print("Voice search tapped")
        animateMicrophoneButton()
    }
}
