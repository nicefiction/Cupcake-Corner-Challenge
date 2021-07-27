// AddressView.swift

import SwiftUI



struct AddressView: View {
   
   // MARK: - PROPERTY WRAPPERS
   
   @ObservedObject var cupcake: Cupcake
   
   
   
   // MARK: - COMPUTED PROPERTIES
   
   var body: some View {
      
      Form {
         Section(header: Text("your order")) {
            Text("\(cupcake.order.numberOfCakes) \(Order.cakeTypes[cupcake.order.cakeTypeIndex]) cakes.")
         }
         Section(header: Text("your address")) {
            TextField("Your name...", text: $cupcake.order.name)
            TextField("Street...", text: $cupcake.order.streetAddress)
            TextField("City...", text: $cupcake.order.city)
            TextField("ZIP...", text: $cupcake.order.zip)
         }
         Section {
            NavigationLink("Checkout", destination: CheckoutView(cupcake: cupcake))
         }
         .disabled(cupcake.order.hasValidAddress == false)
      }
      .navigationBarTitle(Text("Delivery Details"),
                          displayMode: .inline)
   }
}





// MARK: - PREVIEWS -

struct AddressView_Previews: PreviewProvider {
   
   static var previews: some View {
      
      AddressView(cupcake: Cupcake())
   }
}
