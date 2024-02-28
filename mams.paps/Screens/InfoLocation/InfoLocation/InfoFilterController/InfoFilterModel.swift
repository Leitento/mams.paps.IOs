//
//  InfoFilterModel.swift
//  mams.paps
//
//  Created by Kos on 28.02.2024.
//

import UIKit



import Foundation

protocol InfoFilterLocationModelProtocol {
    var stateChanger: ((InfoFilterModel.State) -> Void)? { get set }
    var locations: [Location] { get set }
    func switchNextFlow()
    func getLocation()
}

final class InfoFilterModel {
    enum State {
        case loading
        case done(locations: [Location]?)
        case error(error: String)
    }
    
    
    //MARK: - Properties
    
    private weak var coordinator: InfoFilterLocationCoordinator?
    var locations: [Location] = []
    var stateChanger: ((State) -> Void)?
    var state: State = .loading {
        didSet {
            self.stateChanger?(state)
        }
    }
    var loadingHandler: ((Bool) -> Void)?
    
    
    //MARK: - Life Cycle
    
    init(coordinator: InfoFilterLocationCoordinator) {
        self.coordinator = coordinator
    }
    deinit {
        print("InfoFilterModel  \(#function)")
    }
}

//MARK: - Extension

extension InfoFilterModel: InfoFilterLocationModelProtocol {
    
    //MARK: - Private Methods
    
    func getLocation() {
        NetworkManager.shared.getLocation() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success( let location):
                DispatchQueue.main.async {
                    self.locations = location
                    self.state = .done(locations: location)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.state = .error(error: error.localizedDescription)
                }
            }
        }
    }
    
    func switchNextFlow() {
        
    }
}
