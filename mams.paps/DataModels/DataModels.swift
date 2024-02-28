
import UIKit

struct Location: Hashable {
    let id: Int
    let title: String
    let address: String
    let rating: Double?
    let description: String?
    let image: String?
    let ageCategory: AgeCategory?
    let category: Category?
    let equipment: Equipment?
    let size: Size?
    let sunRainCanopy: Bool?
    let benches: Bool?
    let coating: Coating?
    let accessability: Bool?
    let toilet: Bool?
    let comment: String?
    init(id: Int,
         title: String,
         address: String,
         rating: Double?,
         description: String?,
         image: String?,
         ageCategory: AgeCategory?,
         category: Category?,
         equipment: Equipment?,
         size: Size?,
         sunRainCanopy: Bool?,
         benches: Bool?,
         coating: Coating?,
         accessability: Bool?,
         toilet: Bool?,
         comment: String?) {
        self.id = id
        self.title = title
        self.address = address
        self.rating = rating
        self.description = description
        self.image = image
        self.ageCategory = ageCategory
        self.category = category
        self.equipment = equipment
        self.size = size
        self.sunRainCanopy = sunRainCanopy
        self.benches = benches
        self.coating = coating
        self.accessability = accessability
        self.toilet = toilet
        self.comment = comment
    }
}

extension Location {
    init(location: InfoPlayground) {
        self.id = location.id
        self.title = location.adress
        self.address = location.adress
        self.rating = location.rating
        self.description = location.description
        self.image = location.comment //  костыль, пока картинки нету
        self.ageCategory = AgeCategory(ageCategory: location.ageCategory!)
        self.category = Category.init(category: location.category)
        self.equipment = Equipment.init(sandbox: (location.equipment != nil),
                                        slide: (location.equipment != nil),
                                        swingForKids: (location.equipment != nil),
                                        wallBars: (location.equipment != nil),
                                        gamingComplex: (location.equipment != nil))
        self.size = Size(size: location.size!)
        self.sunRainCanopy = location.sunRainCanopy
        self.benches = location.benches
        self.coating = Coating.init(soft: (location.coating != nil),
                                    sand: (location.coating != nil),
                                    pebbles: (location.coating != nil),
                                    asphalt: (location.coating != nil))
        self.accessability = location.benches
        self.toilet = location.toilet
        self.comment = location.comment
        
    }
}

struct Category: Hashable {
    let title: String
    init(title: String) {
        self.title = title
    }
//    let image: UIImage
}

extension Category {
    init(category: Categoryes) {
        self.title = category.title
    }
}

struct AgeCategory: Hashable {
    let zeroPlus: Bool
    let oneToThree: Bool
    let threeToSix: Bool
    let sixPlus:Bool
    init(zeroPlus: Bool, oneToThree: Bool, threeToSix: Bool, sixPlus: Bool) {
        self.zeroPlus = zeroPlus
        self.oneToThree = oneToThree
        self.threeToSix = threeToSix
        self.sixPlus = sixPlus
    }
}

extension AgeCategory {
    init(ageCategory: AgeCategorys) {
        self.zeroPlus = ageCategory.zeroPlus ?? false
        self.oneToThree = ageCategory.oneToThree ?? false
        self.threeToSix = ageCategory.threeToSix ?? false
        self.sixPlus = ageCategory.sixPlus ?? false
    }
    
}

struct Equipment: Hashable {
    let sandbox: Bool
    let slide: Bool
    let swingForKids: Bool
    let wallBars: Bool
    let gamingComplex: Bool
    init(sandbox: Bool, slide: Bool, swingForKids: Bool, wallBars: Bool, gamingComplex: Bool) {
        self.sandbox = sandbox
        self.slide = slide
        self.swingForKids = swingForKids
        self.wallBars = wallBars
        self.gamingComplex = gamingComplex
    }
}

extension Equipment {
    init(equatable: Equipments) {
        self.sandbox = equatable.sandbox ?? false
        self.slide =  equatable.slide ?? false
        self.swingForKids =  equatable.swingForKids ?? false
        self.wallBars =  equatable.wallBars ?? false
        self.gamingComplex =  equatable.gamingComplex ?? false
    }
}

struct Size: Hashable {
    let small: Bool
    let medium: Bool
    let large: Bool
    init(small: Bool, medium: Bool, large: Bool) {
        self.small = small
        self.medium = medium
        self.large = large
    }
}

extension Size {
    init(size: Sizes) {
        self.small = size.small ?? false
        self.medium = size.medium ?? false
        self.large = size.large ?? false
    }
}

struct Coating: Hashable {
    let soft: Bool
    let sand: Bool
    let pebbles: Bool
    let asphalt: Bool
    init(soft: Bool, sand: Bool, pebbles: Bool, asphalt: Bool) {
        self.soft = soft
        self.sand = sand
        self.pebbles = pebbles
        self.asphalt = asphalt
    }
}

extension Coating {
    init(coating: Coatings) {
        self.soft = coating.soft ?? false
        self.sand = coating.sand ?? false
        self.pebbles = coating.pebbles ?? false
        self.asphalt = coating.asphalt ?? false
    }
}
