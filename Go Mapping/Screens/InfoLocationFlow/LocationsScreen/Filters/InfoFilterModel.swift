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
    func switchNextFlow()
    func getLocation()
    func didTapCategory(category: Category)
}

final class InfoFilterModel {
    enum State {
        case loading
        case done(locations: [Category])
        case chooseCategory(categoryes: Category)
        case error(error: String)
    }
    
    
    //MARK: - Properties
    
    private var categoryes: [Category]
    
    var selectedCategory: Category?
    var stateChanger: ((State) -> Void)?
    var state: State = .loading {
        didSet {
            self.stateChanger?(state)
        }
    }
    var loadingHandler: ((Bool) -> Void)?
    
    
    //MARK: - Life Cycle
    
    init(categoryes: [Category]) {
        self.categoryes = categoryes
    }
    deinit {
        print("InfoFilterModel  \(#function)")
    }
}

//MARK: - Extension

extension InfoFilterModel: InfoFilterLocationModelProtocol {
    
    //MARK: - Private Methods
    
    func getLocation() {
        state = .done(locations: categoryes)
    }
    
    func didTapCategory(category: Category) {
        selectedCategory = category
        state = .chooseCategory(categoryes: category)
    }
    
    func switchNextFlow() {
    }
}
