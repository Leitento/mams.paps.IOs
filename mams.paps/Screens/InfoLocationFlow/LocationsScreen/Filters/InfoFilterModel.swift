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
    func didTapCategory(category: Category)
}

final class InfoFilterModel {
    enum State {
        case loading
        case done(locations: [Category])
        case chooseCategory(locations: [Location])
        case error(error: String)
    }
    
    
    //MARK: - Properties
    
    var locations: [Location]
    var selectedCategory: Category?
    var stateChanger: ((State) -> Void)?
    var state: State = .loading {
        didSet {
            self.stateChanger?(state)
        }
    }
    var loadingHandler: ((Bool) -> Void)?
    
    
    //MARK: - Life Cycle
    
    init(locations: [Location]) {
        self.locations = locations
    }
    deinit {
        print("InfoFilterModel  \(#function)")
    }
    
    
    private func filterLocation(category: Category) -> [Location] {
        var filterLocations: [Location] = []
        locations.forEach { location in
            if location.category == category {
                filterLocations.append(location)
            }
        }
        return filterLocations
    }
}

//MARK: - Extension

extension InfoFilterModel: InfoFilterLocationModelProtocol {
    
    //MARK: - Private Methods
    
    func getLocation() {
        let categoryes = locations.compactMap { $0.category }
        state = .done(locations: categoryes)
    }
    
    func didTapCategory(category: Category) {
        selectedCategory = category
        let locations = filterLocation(category: category)
        state = .chooseCategory(locations: locations)
    }
    
    func switchNextFlow() {
        
    }
}
