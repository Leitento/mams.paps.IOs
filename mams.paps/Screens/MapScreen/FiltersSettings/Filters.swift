

import Foundation

enum Filters {
    case playground([FilterOption])
    case cafe([FilterOption])
    case development([FilterOption])
    case school([FilterOption])
    case medicine([FilterOption])
    case shops([FilterOption])
}

struct FilterOption {
    let name: String
    let iconName: String
}
