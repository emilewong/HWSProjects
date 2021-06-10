//
//  AddressView.swift
//  HWSProjects
//
//  Created by Emile Wong on 8/6/2021.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    var body: some View {
        Form {
            Section {
                TextField("Name: ", text: $order.name)
                TextField("Street Address: ", text: $order.streetAddress)
                TextField("City: ", text: $order.city)
                TextField("Zip: ", text: $order.zip)
            } //: SECTION
            
            Section{
                NavigationLink(destination: CheckoutView(order: order)){
                    Text("Check Out")
                }
            } //: SECTION
            .disabled(order.hasValidAddress == false)
        } //: FORM
        .navigationBarTitle("Delivery Details", displayMode: .inline)
    }
}


struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
