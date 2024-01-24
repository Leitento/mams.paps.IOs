

import CoreLocation

final class LocationService: NSObject {
    
    private let locationManager = CLLocationManager()
    var isLocationAuthorized: Bool = false
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func updateauthorizationStatus() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

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
