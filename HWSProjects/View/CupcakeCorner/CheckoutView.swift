//
//  CheckOutView.swift
//  HWSProjects
//
//  Created by Emile Wong on 8/6/2021.
//

import SwiftUI

struct CheckoutView: View {
    // MARK: - PROPERTIES
    @ObservedObject var order: Order
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    // MARK: - FUNCTIONS
    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknow error").")
                self.confirmationMessage = "Failed to place your order, please try again later."
                self.showingConfirmation = true
                return
            }
            
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                self.confirmationMessage = "Your order for \(decodedOrder.quantity) x \(Order.types[decodedOrder.type].lowercased())  cupcakes is on the way!"
                self.showingConfirmation = true
            } else {
                print ("Invalid response from server")
            }
        }.resume()
        
    }
    
    // MARK: - BODY
    var body: some View {
        GeometryReader { geo in
            ScrollView{
                VStack{
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text("Your order is \(self.order.cost, specifier: "%.2f")")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    
                    Button("Place order"){
                        // PLACE THE ORDER
                        self.placeOrder()
                    }
                    .padding()
                } //: VSTACK
            } //: SCROLL
        } //: READER
        .navigationBarTitle("Check out", displayMode: .inline)
        .alert(isPresented: $showingConfirmation, content: {
            Alert(title: Text("Thank you!"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
        })
    }
}
// MARK: - PREVIEW
struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
