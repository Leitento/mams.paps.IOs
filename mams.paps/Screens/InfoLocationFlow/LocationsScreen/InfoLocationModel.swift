
import Foundation

protocol InfoLocationModelProtocol {
    var stateChanger: ((InfoLocationModel.State) -> Void)? { get set }
    var locations: [Location] { get set }
    var loadingHandler: ((Bool) -> Void)? { get set }
    func switchToNextFlow()
    func getLocation()
    func didTapCategory(_ category: [Location])
}

final class InfoLocationModel {
    
    enum State {
//        case initing
        case loading
        case done(locations: [Location])
        case filtered(locations: [Location])
        case showFilterView(locations: [Location])
        case error(error: String)
    }
    
    
    //MARK: - Properties
    
    private weak var coordinator: InfoLocationCoordinator?
    var locations: [Location] = []
    var stateChanger: ((State) -> Void)?
    var state: State = .loading {
        didSet {
            self.stateChanger?(state)
        }
    }
    var loadingHandler: ((Bool) -> Void)?
    
    
    //MARK: - Life Cycle
    
    init(coordinator: InfoLocationCoordinator) {
        self.coordinator = coordinator
    }
    deinit {
        print("InfoLocationModel  \(#function)")
    }
}

//MARK: - Extension

extension InfoLocationModel: InfoLocationModelProtocol {
    
    func switchToNextFlow() {
        state = .showFilterView(locations: locations)
    }
    
    func getLocation() {
        NetworkManager.shared.getLocation() { [weak self] result in
            guard let self = self else { return }
            //                self.state = .loading
            switch result {
            case .success( let location):
                DispatchQueue.main.async {
                    self.locations = location
                    self.state = .done(locations: location)
                    print("3 \(location)")
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.state = .error(error: error.localizedDescription)
                }
            }
            self.loadingHandler?(false)
        }
    }
    
//    func filterLocation() {
//        NetworkManager.shared.getLocation() { [weak self] result in
//            guard let self = self else { return }
//            //                self.state = .loading
//            switch result {
//            case .success( let location):
//                DispatchQueue.main.async {
//                    self.locations = location
//                    self.state = .filtered(locations: location)
//                }
//            case .failure(let error):
//                DispatchQueue.main.async {
//                    self.state = .error(error: error.localizedDescription)
//                }
//            }
//            self.loadingHandler?(false)
//        }
//    }
    
    func didTapCategory(_ category: [Location]) {
        state = .filtered(locations: category)
    }
}

