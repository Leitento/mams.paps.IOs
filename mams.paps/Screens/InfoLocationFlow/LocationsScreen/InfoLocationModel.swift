
import Foundation

protocol InfoLocationModelProtocol {
    var stateChanger: ((InfoLocationModel.State) -> Void)? { get set }
//    var locations: [Location] { get set }
    func switchToNextFlow()
    func getLocation()
    func didTapCategory(_ category: Category)
    func hideFilter()
}

final class InfoLocationModel {
    
    enum State {
//        case initing
        case loading
        case done(locations: [Location])
//        case filtered(locations: [Location])
        case showFilterView(locations: [Category])
        case error(error: String)
    }
    
    
    //MARK: - Properties
    
    private weak var coordinator: InfoLocationCoordinator?
    private var locations: [Location] = []
    private var categoryes: [Category] = []
    var stateChanger: ((State) -> Void)?
    var state: State = .loading {
        didSet {
            self.stateChanger?(state)
        }
    }
    private let apiService: LocationApiServiceProtocol

    
    //MARK: - Life Cycle
    
    init(coordinator: InfoLocationCoordinator, apiService: LocationApiServiceProtocol) {
        self.coordinator = coordinator
        self.apiService = apiService
    }
    deinit {
        print("InfoLocationModel  \(#function)")
    }
    
    
    private func getLocations() {
        Task {  @MainActor [weak self] in
            guard let self else { return }
            do {
                let locations = try await apiService.getLocations()
                self.locations = locations
                self.state = .done(locations: locations)
            } catch {
                self.state = .error(error: error.localizedDescription)
            }
        }
    }
    
    private func getCategoryes() {
        Task {  @MainActor [weak self] in
            guard let self else { return }
            do {
                let categoryes = try await apiService.getCategoryes()
                self.categoryes = categoryes
            } catch {
                self.state = .error(error: error.localizedDescription)
            }
        }
    }
    
    private func filterLocations(category: Category) -> [Location] {
        var filteredLocations: [Location] = []
         locations.forEach { location in
            if category.id == location.category.id {
                filteredLocations.append(location)
            }
        }
        return filteredLocations
    }
}

//MARK: - Extension

extension InfoLocationModel: InfoLocationModelProtocol {
    
    func switchToNextFlow() {
        state = .showFilterView(locations: categoryes)
    }
    
    func didTapCategory(_ category: Category) {
        let locations = filterLocations(category: category)
        state = .done(locations: locations)
    }
    
    func hideFilter() {
        getLocations()
    }
    
    func getLocation() {
        getLocations()
        getCategoryes()
    }
    
}

