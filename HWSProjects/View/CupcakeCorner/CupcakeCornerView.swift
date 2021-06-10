//
//  CupcakeCornerView.swift
//  HWSProjects
//
//  Created by Emile Wong on 6/6/2021.
//

import SwiftUI

struct CupcakeCornerView: View {
    // MARK: - PROPERTIES
    @ObservedObject var order = Order()
    
    // MARK: - BODY
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Picker("Select your cake type", selection: $order.type){
                        ForEach(0..<Order.types.count, id: \.self){
                            Text(Order.types[$0])
                        }
                    }
                    Stepper(value: $order.quantity, in: 3...20){
                        Text("Number of cakes: \(order.quantity)")
                    }
                } //: SECTION
                
                Section {
                    Toggle(isOn: $order.specialRequestEnabled.animation()){
                        Text("Any special request?")
                    }
                    if order.specialRequestEnabled {
                        Toggle(isOn: $order.extraFrosting, label: {
                            Text("Add extra frosting")
                        })
                        
                        Toggle(isOn: $order.addSprinkles, label: {
                            Text("Add extra sprinkles")
                        })
                    }
                } //: SECITON
                
                Section {
                    NavigationLink(
                        destination: AddressView(order: order),
                        label: {
                            Text("Delivery Detail")
                        }) //: LINK
                } //: SECTION
            } //: FORM
            .navigationTitle("Cupcake Corner")
        } //: NAVIGATION
    }
}
// MARK: - PREVIEW
struct CupcakeCornerView_Previews: PreviewProvider {
    static var previews: some View {
        CupcakeCornerView(order: Order())
    }
}
