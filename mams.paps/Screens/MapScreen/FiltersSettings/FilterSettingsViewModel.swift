

import Foundation

protocol FiltersSettingsViewModelProtocol: AnyObject {
    func getFilterName() -> String
    func getImageName() -> String
    func getLabelText() -> String
}

final class FiltersSettingsViewModel {
    
    // MARK: - Private properties
    private let filterCategories: [FilterCategory] = FilterCategory.make()
    private var selectedItemIndex: Int
                
    //MARK: - Life Cycles
    init(selectedItemIndex: Int) {
        self.selectedItemIndex = selectedItemIndex
    }
}

//MARK: - FiltersSettingsViewModelProtocol
extension FiltersSettingsViewModel: FiltersSettingsViewModelProtocol {
    
    func getFilterName() -> String {
        print(filterCategories[selectedItemIndex].title)
        return filterCategories[selectedItemIndex].title
    }
    
    func getImageName() -> String {
        return filterCategories[selectedItemIndex].imageName
    }
    
    func getLabelText() -> String {
        return filterCategories[selectedItemIndex].labelText
    }
}
