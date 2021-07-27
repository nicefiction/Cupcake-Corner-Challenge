// CheckoutView.swift

import SwiftUI



struct CheckoutView: View {
   
   // MARK: - WRAPPERS
   
   let cupcake: Cupcake
   
   
   
   // MARK: - COMPUTED PROPERTIES
   
   var body: some View {
      
      Text("\(cupcake.order.numberOfCakes) \(Order.cakeTypes[cupcake.order.cakeTypeIndex]) cupcakes")
   }
}





// MARK: - PREVIEWS -

struct CheckoutView_Previews: PreviewProvider {
   
   static var previews: some View {
      
      CheckoutView(cupcake: Cupcake())
   }
}
