

import CoreLocation 

protocol LocationServiceProtocol: AnyObject {
    func getCurrentLocation(completion: @escaping (Result<Coordinates, LocationServiceError>) -> Void)
}

final class LocationService: NSObject {
    
    // MARK: - Private properties
    private let locationManager = CLLocationManager()
    
    // MARK: - Properties
    private var isLocationAuthorized: Bool = false
    private var currentLocation: Coordinates?
    
    // MARK: - Life Cycle
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        updateAuthorizationStatus()
    }
    
    //MARK: - Methods
    private func updateAuthorizationStatus() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, let location = locations.last {
            locationManager.stopUpdatingLocation()
            currentLocation = Coordinates(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
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

// MARK: - CLLocationManagerDelegate - LocationServiceProtocol
extension LocationService: LocationServiceProtocol {
    func getCurrentLocation(completion: @escaping (Result<Coordinates, LocationServiceError>) -> Void) {
        guard isLocationAuthorized else {
            completion(.failure(LocationServiceError.authorizationDenied))
            return
        }
        
        guard let currentLocation = currentLocation else {
            completion(.failure(LocationServiceError.locationUnavailable))
            return
        }
        
        completion(.success(currentLocation))
    }
}
    
