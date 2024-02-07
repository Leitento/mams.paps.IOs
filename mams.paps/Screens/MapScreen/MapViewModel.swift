

import Foundation

protocol MapViewModelProtocol: AnyObject {
    func fetchCurrentLocation(completion: @escaping (Result<Coordinates, LocationServiceError>) -> Void)
}

final class MapViewModel {
    
    //MARK: - Private Properties
    private let locationService: LocationServiceProtocol
    private let coordinator: MapCoordinatorProtocol
    
    //MARK: - Life Cycles
    init(locationService: LocationServiceProtocol, coordinator: MapCoordinatorProtocol) {
        self.locationService = locationService
        self.coordinator = coordinator
    }
}

    //MARK: - MapViewModelProtocol
extension MapViewModel: MapViewModelProtocol {
    
    func fetchCurrentLocation(completion: @escaping (Result<Coordinates, LocationServiceError>) -> Void) {
        locationService.getCurrentLocation { result in
            switch result {
            case .success(let coordinates):
                completion(.success(coordinates))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
