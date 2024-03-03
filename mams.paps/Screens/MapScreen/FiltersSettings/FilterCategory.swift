

import Foundation

struct FilterCategory {
    let title: String
    let imageName: String
    let labelText: String
    let options: [Filters]
}

extension FilterCategory {
    static func make() -> [Self] {
        
        let playgroundOptions: [FilterOption] = [
            FilterOption(name: "Rating".localized,
                         iconName: "rating"),
            FilterOption(name: "AgeGroup".localized,
                         iconName: "ageGroup"),
            FilterOption(name: "Equipment".localized,
                         iconName: "equipment"),
            FilterOption(name: "Size".localized,
                         iconName: "size"),
            FilterOption(name: "Toilet".localized,
                         iconName: "toilet"),
            FilterOption(name: "Canopy".localized,
                         iconName: "canopy"),
            FilterOption(name: "Benches".localized,
                         iconName: "benches"),
            FilterOption(name: "Covering".localized,
                         iconName: "covering"),
            FilterOption(name: "LimitedMobilityEquipment".localized,
                         iconName: "limitedMobilityEquipment")
        ]
        
        let cafeOptions: [FilterOption] = [
            FilterOption(name: "Rating".localized,
                         iconName: "rating")
        ]
        
        let developmentOptions: [FilterOption] = [
            FilterOption(name: "Rating".localized,
                         iconName: "rating")
        ]
        
        let schoolOptions: [FilterOption] = [
            FilterOption(name: "Rating".localized,
                         iconName: "rating")
        ]
        
        let medicineOptions: [FilterOption] = [
            FilterOption(name: "Rating".localized,
                         iconName: "rating")
        ]
        
        let shopsOptions: [FilterOption] = [
            FilterOption(name: "Rating".localized,
                         iconName: "rating")
        ]
        
        return [
            FilterCategory(title: "PopupMenuItem.Playground".localized,
                           imageName: "popupPlayground",
                           labelText: "FilterCategoryLabel.Playground".localized,
                           options: [.playground(playgroundOptions)]
                            ),
            FilterCategory(title: "PopupMenuItem.Cafe".localized,
                           imageName: "popupCafe",
                           labelText: "FilterCategoryLabel.Cafe".localized,
                           options: [.cafe(cafeOptions)]
                          ),
            FilterCategory(title: "PopupMenuItem.Development".localized + ", " + "PopupMenuItem.Courses".localized,
                           imageName: "popupDevelopment",
                           labelText: "FilterCategoryLabel.Development".localized,
                           options: [.development(developmentOptions)]
                          ),
            FilterCategory(title: "PopupMenuItem.Kindergartens".localized + ", " + "PopupMenuItem.Schools".localized,
                           imageName: "popupSchools",
                           labelText: "FilterCategoryLabel.Schools".localized,
                           options: [.school(schoolOptions)]
                          ),
            FilterCategory(title: "PopupMenuItem.Pharmacies".localized + ", " + "PopupMenuItem.Clinics".localized,
                           imageName: "popupMedicine",
                           labelText: "FilterCategoryLabel.Medicine".localized,
                           options: [.medicine(medicineOptions)]
                          ),
            FilterCategory(title: "PopupMenuItem.Shops".localized,
                           imageName: "popupShops",
                           labelText: "FilterCategoryLabel.Shops".localized,
                           options: [.shops(shopsOptions)]
                          ),
        ]
    }
}
