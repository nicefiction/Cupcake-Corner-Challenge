// CheckoutView.swift

import SwiftUI



struct CheckoutView: View {
   
   // MARK: - PROPERTY WRAPPERS
   
   let cupcake: Cupcake
   @State private var isShowingConfirmationAlert: Bool = false
   @State private var confirmationMessage: String = ""
   @State private var isShowingFailureAlert: Bool = false
   @State private var failureMessage: String = "There is no internet connection."
   
   
   
   // MARK: - COMPUTED PROPERTIES
   
   var body: some View {
      
      GeometryReader { geometryProxy in
         ScrollView(.vertical) {
            VStack {
               Image("cupcakes")
                  .resizable()
                  .scaledToFit()
                  .frame(width: geometryProxy.size.width)
               Text("Your order: $ \(cupcake.order.totalPrice, specifier: "%.2f")")
               Button(action: {
                  print("The button is tapped.")
                  placeOrder()
               }) {
                  Text("Place Order")
               }
               .padding()
               .alert(isPresented: isShowingConfirmationAlert ? $isShowingConfirmationAlert : $isShowingFailureAlert) {
                  Alert(title: Text("\(isShowingConfirmationAlert ? "Thank you!" : "Error")"),
                        message: Text("\(isShowingConfirmationAlert ? confirmationMessage : failureMessage)"),
                        dismissButton: .default(Text("OK")))
               }
            }
         }
      }
      .navigationBarTitle("Checkout",
                          displayMode: .inline)
   }
   
   
   
   // MARK: METHODS
   
   /** OVERVIEW :
    `Codable` —> Converts Swift objects to and from JSON .
    `URLRequest`—> Configures how data should be sent .
    `URLSession`—> Sends and receives data .
    */
   func placeOrder() {
      
      /// 1. Convert our current Order object into some JSON data that can be sent :
      let jsonEncoder: JSONEncoder = JSONEncoder()
      guard let _encodedData = try? jsonEncoder.encode(cupcake.order)
      else {
         print("Failed to encode order.")
         return
      }
      
      /// 2. Prepare a URLRequest to send our encoded data as JSON :
      let cupcakesURL = URL(string: "https://reqres.in/api/cupcakes")!
      var urlRequest = URLRequest(url: cupcakesURL)
      urlRequest.setValue("application/json",
                          forHTTPHeaderField: "Content-Type")
      urlRequest.httpMethod = "POST"
      urlRequest.httpBody = _encodedData
      
      
      /// 3. Run that request and process the response :
      URLSession.shared.dataTask(with: urlRequest) { (data: Data?,
                                                      urlResponse: URLResponse?,
                                                      error: Error?) in
         /// If something went wrong – we’ll just print a message and return  :
         guard let _data = data
         else {
            print("No data in response: \(error?.localizedDescription ?? "Unknown Error")")
            isShowingFailureAlert.toggle()
            return
         }
         
         
         if let _decodedOrder = try? JSONDecoder().decode(Order.self,
                                                          from: _data) {
            self.confirmationMessage = "You have ordered \(_decodedOrder.numberOfCakes) \(Order.cakeTypes[_decodedOrder.cakeTypeIndex].lowercased()) cakes."
            isShowingConfirmationAlert.toggle()
         } else {
            print("There has been an invalid response from the server.")
         }
      }.resume()
   }
}





// MARK: - PREVIEWS -

struct CheckoutView_Previews: PreviewProvider {
   
   static var previews: some View {
      
      CheckoutView(cupcake: Cupcake())
   }
}
