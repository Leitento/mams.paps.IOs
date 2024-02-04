//
//  Array.swift
//  mams.paps
//
//  Created by Юлия Кагирова on 09.01.2024.
//

import UIKit
extension Array {
    subscript(safeIndex index: Int) -> Element? {
        get {
            guard index < count && index >= 0 else { return nil }
            return self[index]
        }

        set {
            guard let newValue else { return }
            self[index] = newValue
        }
    }
}
