//
//  UIColor Dark.swift
//  mams.paps
//
//  Created by Kos on 04.03.2024.
//

import UIKit

extension UIColor {
    func darken(by percentage: CGFloat) -> UIColor {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        let amount = 1.0 - percentage
        red = max(0, red * amount)
        green = max(0, green * amount)
        blue = max(0, blue * amount)

        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
