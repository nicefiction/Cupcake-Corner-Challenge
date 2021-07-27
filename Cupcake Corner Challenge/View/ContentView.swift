// ContentView.swift

import SwiftUI



struct ContentView: View {
   
   // MARK: - PROPERTY WRAPPERS
   
   @ObservedObject var cupcake: Cupcake = Cupcake()
   
   
   
   // MARK: - COMPUTED PROPERTIES
   
   var body: some View {
      
      NavigationView {
         Form {
            Section {
               Picker("Flavor",
                      selection: $cupcake.order.cakeTypeIndex) {
                  
                  ForEach(0..<Order.cakeTypes.count,
                          id: \.self) { index in
                     Text("\(Order.cakeTypes[index])")
                  }
               }
               Stepper("\(cupcake.order.numberOfCakes) cupcakes",
                       value: $cupcake.order.numberOfCakes,
                       in: 3...9)
            }
            Section {
               Toggle("Special Requests",
                      isOn: $cupcake.order.hasSpecialRequestEnabled
                        .animation(Animation.default))
               if cupcake.order.hasSpecialRequestEnabled {
                  Group {
                     Toggle("Sprinkles",
                            isOn: $cupcake.order.hasSprinkles)
                     Toggle("Frosting",
                            isOn: $cupcake.order.hasFrosting)
                  }
               }
            }
            Section {
               NavigationLink("Delivery Details",
                              destination: AddressView(cupcake: cupcake))
            }
         }
         .navigationBarTitle(Text("Cupcake Corner"))
      }
   }
}





// MARK: - PREVIEWS -

struct ContentView_Previews: PreviewProvider {
   
   static var previews: some View {
      
      ContentView()
   }
}
