

import Foundation

struct PopupMenuItem {
    var imageName: String
    var text: String
}

extension PopupMenuItem {
    static func make() -> [Self] {
        [
            PopupMenuItem(imageName: "popupPlayground", 
                          text: "PopupMenuItem.Playground".localized),
            PopupMenuItem(imageName: "popupCafe", 
                          text: "PopupMenuItem.Cafe".localized),
            PopupMenuItem(imageName: "popupDevelopment",
                          text: "PopupMenuItem.Development".localized + ",\n" + "PopupMenuItem.Courses".localized),
            PopupMenuItem(imageName: "popupSchools", 
                          text: "PopupMenuItem.Kindergartens".localized + ",\n" + "PopupMenuItem.Schools".localized),
            PopupMenuItem(imageName: "popupMedicine",
                          text: "PopupMenuItem.Pharmacies".localized + ",\n" + "PopupMenuItem.Clinics".localized),
            PopupMenuItem(imageName: "popupShops",
                          text: "PopupMenuItem.Shops".localized)
        ]
    }
}
