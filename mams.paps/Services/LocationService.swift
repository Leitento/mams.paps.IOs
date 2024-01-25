

import CoreLocation

final class LocationService: NSObject {
    
    // MARK: - Private properties
    private let locationManager = CLLocationManager()
    
    // MARK: - Properties
    var isLocationAuthorized: Bool = false
    
    // MARK: - Life Cycle
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    //MARK: - Methods
    func updateauthorizationStatus() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty {
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            isLocationAuthorized = true
        case .denied, .restricted, .notDetermined:
            isLocationAuthorized = false
        @unknown default:
            fatalError("Location permission status unknown")
        }
    }
}
