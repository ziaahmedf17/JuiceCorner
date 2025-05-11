//
//  AddressView.swift
//  JuiceCorner
//
//  Created by Zi on 11/05/2025.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Form{
            Section
            {
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }
            Section{
                NavigationLink{
                    CheckoutView(order: order)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Delivery Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AddressView(order: Order ())
        }
    }
}
