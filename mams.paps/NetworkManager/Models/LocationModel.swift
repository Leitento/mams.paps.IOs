

import Foundation

struct PlaygroundModel: Codable {
    let playgrounds: [InfoPlayground]
}


struct InfoPlayground: Codable {
    let id: Int
    let adress: String
    let rating: Double
    let ageCategory: AgeCategorys?
    let category: Categoryes
    let equipment: Equipments?
    let size: Sizes?
    let toilet: Bool?
    let sunRainCanopy: Bool?
    let benches: Bool?
    let coating: Coatings?
    let equipmentForPeopleLimitedMobility: Bool?
    let description: String?
    let comment: String?
    
}

struct Categoryes: Codable {
    let id: Int
    let title: String
}

struct AgeCategorys: Codable {
    let zeroPlus: Bool?
    let oneToThree: Bool?
    let threeToSix: Bool?
    let sixPlus: Bool?
}

struct Equipments: Codable {
    let sandbox: Bool?
    let slide: Bool?
    let swingForKids: Bool?
    let swingOlderChildren: Bool?
    let wallBars: Bool?
    let gamingComplex: Bool?
}


struct Sizes: Codable {
    let small: Bool?
    let medium: Bool?
    let large: Bool?
}


struct Coatings: Codable {
    let soft: Bool?
    let pebbles: Bool?
    let sand: Bool?
    let asphalt: Bool?
}


