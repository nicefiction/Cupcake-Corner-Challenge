// Order.swift

import Foundation



struct Order: Codable {
   
   // MARK: - PROPERTIES
   
   static let cakeTypes: [String] = [
      
      "Vanilla", "Chocolate", "Cinnamon", "Carrot"
   ]
   
   var cakeTypeIndex: Int = 0
   var numberOfCakes: Int = 3
   var hasSpecialRequestEnabled: Bool = false {
      didSet {
         if hasSpecialRequestEnabled == false {
            hasFrosting = false
            hasSprinkles = false
         }
      }
   }
   var hasFrosting: Bool = false
   var hasSprinkles: Bool = false
   var name: String = ""
   var streetAddress: String = ""
   var city: String = ""
   var zip: String = ""
   
   
   
   // MARK: - COMPUTED PROPERTIES
   
   var hasValidAddress: Bool {
      
      let isValidName: Bool = name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
      let isValidStreetAddress: Bool = streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
      let isValidCity: Bool = city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
      let isValidZIP: Bool = zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
      
      return isValidName || isValidStreetAddress || isValidCity || isValidZIP ? false : true
   }
   
   
   var totalPrice: Double {
      
      // Base cost:
      var cupcakeCost = 2 * Double(numberOfCakes)
      // + Flavor:
      cupcakeCost += Double(cakeTypeIndex) / 2
      // + Sprinkles:
      cupcakeCost += hasSprinkles ? Double(numberOfCakes) : 0
      // + Frosting:
      cupcakeCost += hasSprinkles ? Double(numberOfCakes) / 2 : 0
      
      return cupcakeCost
   }
}
