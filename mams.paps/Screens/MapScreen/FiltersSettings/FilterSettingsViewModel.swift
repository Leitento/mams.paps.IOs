

import Foundation

protocol FiltersSettingsViewModelProtocol: AnyObject {
    func getFilterName() -> String
    func getImageName() -> String
    func getLabelText() -> String
    func getFilterOptions() -> [FilterOption]
    func getSettingsOption(for filterIndex: Int) -> [SettingsOption]
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
        return filterCategories[selectedItemIndex].title
    }
    
    func getImageName() -> String {
        return filterCategories[selectedItemIndex].imageName
    }
    
    func getLabelText() -> String {
        return filterCategories[selectedItemIndex].labelText
    }
    
    func getFilterOptions() -> [FilterOption] {
        
        let filters = filterCategories[selectedItemIndex].options
        
        let allOptions = filters.flatMap { filter -> [FilterOption] in
            switch filter {
            case .playground(let options),
                 .cafe(let options),
                 .development(let options),
                 .school(let options),
                 .medicine(let options),
                 .shops(let options):
                return options
            }
        }
        return allOptions
    }
    
    func getSettingsOption(for filterIndex: Int) -> [SettingsOption] {
        
        let filters = filterCategories[selectedItemIndex].options
        
        let allOptions = filters.flatMap { filter -> [FilterOption] in
            switch filter {
            case .playground(let options),
                    .cafe(let options),
                    .development(let options),
                    .school(let options),
                    .medicine(let options),
                    .shops(let options):
                return options
            }
        }
        
        let settings = allOptions[filterIndex].settings
        
        return settings
    }
}
