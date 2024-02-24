

import Foundation

protocol Configurable: AnyObject {
    associatedtype T
    func setup(with items: T)
}
