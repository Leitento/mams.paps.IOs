

import Foundation

struct MainMenuItem {
    var imageName: String
    var text: String
}

extension MainMenuItem {
    public static func make() -> [Self] {
        [
            MainMenuItem(imageName: "mainCell1", text: "MainMenuItem.Navigation".localized),
            MainMenuItem(imageName: "mainCell2", text: "MainMenuItem.Events".localized),
            MainMenuItem(imageName: "mainCell3", text: "MainMenuItem.Services".localized),
            MainMenuItem(imageName: "mainCell4", text: "MainMenuItem.Useful".localized)
        ]
    }
}
