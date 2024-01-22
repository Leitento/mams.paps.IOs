//
//  mams.paps
//
//  Created by Юлия Кагирова on 21.12.2023.
//

import UIKit

final class LocationsListViewModel {
    
    enum State {
        case loading
        case loaded(locations: [Any])
        case error(error: String)
    }
    
    
}
