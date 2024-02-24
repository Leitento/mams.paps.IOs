

import Foundation

struct PopupMenuItem {
    var imageName: String
    var text: String
}

extension PopupMenuItem {
    public static func make() -> [Self] {
        [
            PopupMenuItem(imageName: "popupCell1", text: "PopupMenuItem.Playground".localized),
            PopupMenuItem(imageName: "popupCell2", text: "PopupMenuItem.Cafe".localized),
            PopupMenuItem(imageName: "popupCell3", text: "PopupMenuItem.Development".localized),
            PopupMenuItem(imageName: "popupCell4", text: "PopupMenuItem.Schools".localized),
            PopupMenuItem(imageName: "popupCell5", text: "PopupMenuItem.Medicine".localized),
            PopupMenuItem(imageName: "popupCell6", text: "PopupMenuItem.Shops".localized)
        ]
    }
}
