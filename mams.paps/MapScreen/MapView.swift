

import UIKit
import YandexMapsMobile

protocol MapViewProtocol: AnyObject {
    
}

final class MapView: UIView {
    
    private enum Constants {
        static let buttonSize: CGFloat = 48.0
        static let buttonMargin: CGFloat = 16.0
        static let buttonCornerRadius: CGFloat = 8.0
    }
    
    @objc public var mapView: YMKMapView!
    
    private var map: YMKMap?
    
    private lazy var buttonsContainer: UIStackView = {
        let buttonsContainer = UIStackView()
        buttonsContainer.translatesAutoresizingMaskIntoConstraints =  false
        buttonsContainer.axis = .vertical
        buttonsContainer.spacing = Constants.buttonMargin
        buttonsContainer.addArrangedSubview(plusZoomButton)
        buttonsContainer.addArrangedSubview(minusZoomButton)
        return buttonsContainer
    }()
    
    private let plusZoomButton: UIButton = {
        let plusZoomButton = UIButton()
        plusZoomButton.translatesAutoresizingMaskIntoConstraints = false
        plusZoomButton.setImage(UIImage(systemName: "plus"), for: .normal)
        plusZoomButton.addTarget(MapView.self, action: #selector(zoomIn), for: .touchUpInside)
        plusZoomButton.layer.cornerRadius = Constants.buttonCornerRadius
        plusZoomButton.backgroundColor = .systemGray
        return plusZoomButton
    }()
    
    private let minusZoomButton: UIButton = {
        let minusZoomButton = UIButton()
        minusZoomButton.translatesAutoresizingMaskIntoConstraints = false
        minusZoomButton.setImage(UIImage(systemName: "minus"), for: .normal)
        minusZoomButton.addTarget(MapView.self, action: #selector(zoomOut), for: .touchUpInside)
        minusZoomButton.layer.cornerRadius = Constants.buttonCornerRadius
        minusZoomButton.backgroundColor = .systemGray
        return minusZoomButton
    }()
    
//    override init(frame: CGRect, scaleFactor: Float, vulkanPreferred: Bool, lifecycleProvider: YRTLifecycleProvider?) {
//        super.init(frame: frame, scaleFactor: scaleFactor, vulkanPreferred: vulkanPreferred, lifecycleProvider: lifecycleProvider)
//        addSubviews()
//        setupConstraints()
//        mapWindow.map.mapType = .map
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        addSubviews()
        setupConstraints()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        mapView = YMKMapView(frame: bounds, vulkanPreferred: MapView.isM1Simulator())
        mapView.mapWindow.map.mapType = .map
    }
    
    private func addSubviews() {
        addSubview(buttonsContainer)
    }
        
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            buttonsContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.buttonMargin),
            buttonsContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
            buttonsContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            plusZoomButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize),
            plusZoomButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize),
            
            minusZoomButton.widthAnchor.constraint(equalToConstant: Constants.buttonSize),
            minusZoomButton.heightAnchor.constraint(equalToConstant: Constants.buttonSize),
            
        ])
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
    
    static func isM1Simulator() -> Bool {
        return (TARGET_IPHONE_SIMULATOR & TARGET_CPU_ARM64) != 0
    }
    
    @objc
    private func zoomIn() {
        changeZoom(by: 1.0)
    }

    @objc
    private func zoomOut() {
        changeZoom(by: -1.0)
    }
}
