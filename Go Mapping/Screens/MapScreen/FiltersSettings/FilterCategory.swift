

import Foundation

struct FilterCategory {
    let title: String
    let imageName: String
    let labelText: String
    let options: [Filters]
}

extension FilterCategory {
    static func make() -> [Self] {
        
        let ratingSettings: [SettingsOption] = [
            SettingsOption(name: ">" + "3"),
            SettingsOption(name: ">" + "3,5"),
            SettingsOption(name: ">" + "4"),
            SettingsOption(name: ">" + "4,5")
        ]
        
        let ageGroupSettings: [SettingsOption] = [
            SettingsOption(name: "0+"),
            SettingsOption(name: "1-3"),
            SettingsOption(name: "3-6"),
            SettingsOption(name: "6+")
        ]
        
        let equipmentSettings: [SettingsOption] = [
            SettingsOption(name: "EquipmentSettings.Playground".localized),
            SettingsOption(name: "EquipmentSettings.Slide".localized),
            SettingsOption(name: "EquipmentSettings.SwingsForBaby".localized),
            SettingsOption(name: "EquipmentSettings.SwingsForChildren".localized),
            SettingsOption(name: "EquipmentSettings.WallBars".localized),
            SettingsOption(name: "EquipmentSettings.ElaboratePlaygroundSet".localized)
        ]
        
        let sizeSettings: [SettingsOption] = [
            SettingsOption(name: "SizeSettings.Small".localized),
            SettingsOption(name: "SizeSettings.Medium".localized),
            SettingsOption(name: "SizeSettings.Large".localized)
        ]
        
        let coveringSettings: [SettingsOption] = [
            SettingsOption(name: "CoveringSettings.Soft".localized),
            SettingsOption(name: "CoveringSettings.Pebbles".localized),
            SettingsOption(name: "CoveringSettings.Sand".localized),
            SettingsOption(name: "CoveringSettings.Asphalt".localized)
        ]
        
        let booleanSettings: [SettingsOption] = [
            SettingsOption(name: "BooleanSettings.Yes".localized),
            SettingsOption(name: "BooleanSettings.No".localized),
        ]
        
        let playgroundOptions: [FilterOption] = [
            FilterOption(name: "Rating".localized,
                         iconName: "rating",
                         settings: ratingSettings),
            FilterOption(name: "AgeGroup".localized,
                         iconName: "ageGroup",
                         settings: ageGroupSettings),
            FilterOption(name: "Equipment".localized,
                         iconName: "equipment",
                         settings: equipmentSettings),
            FilterOption(name: "Size".localized,
                         iconName: "size",
                         settings: sizeSettings),
            FilterOption(name: "Toilet".localized,
                         iconName: "toilet",
                         settings: booleanSettings),
            FilterOption(name: "Canopy".localized,
                         iconName: "canopy",
                         settings: booleanSettings),
            FilterOption(name: "Benches".localized,
                         iconName: "benches",
                         settings: booleanSettings),
            FilterOption(name: "Covering".localized,
                         iconName: "covering",
                         settings: coveringSettings),
            FilterOption(name: "LimitedMobilityEquipment".localized,
                         iconName: "limitedMobilityEquipment", 
                         settings: booleanSettings)
        ]
        
        let cafeOptions: [FilterOption] = [
            FilterOption(name: "Rating".localized,
                         iconName: "rating",
                         settings: ratingSettings)
        ]
        
        let developmentOptions: [FilterOption] = [
            FilterOption(name: "Rating".localized,
                         iconName: "rating",
                         settings: ratingSettings)
        ]
        
        let schoolOptions: [FilterOption] = [
            FilterOption(name: "Rating".localized,
                         iconName: "rating",
                         settings: ratingSettings)
        ]
        
        let medicineOptions: [FilterOption] = [
            FilterOption(name: "Rating".localized,
                         iconName: "rating",
                         settings: ratingSettings)
        ]
        
        let shopsOptions: [FilterOption] = [
            FilterOption(name: "Rating".localized,
                         iconName: "rating",
                         settings: ratingSettings)
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
