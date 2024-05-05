

import Foundation

struct MainScreenMenuItem {
    var imageName: String
    var text: String
}

extension MainScreenMenuItem {
    public static func make() -> [Self] {
        [
            MainScreenMenuItem(imageName: "mainCell1", text: "MainScreenMenuItem.Navigation".localized),
            MainScreenMenuItem(imageName: "mainCell2", text: "MainScreenMenuItem.Events".localized),
            MainScreenMenuItem(imageName: "mainCell3", text: "MainScreenMenuItem.Services".localized),
            MainScreenMenuItem(imageName: "mainCell4", text: "MainScreenMenuItem.Useful".localized)
        ]
    }
}
