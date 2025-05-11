//
//  ContentView.swift
//  JuiceCorner
//
//  Created by Zi on 11/05/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var order = Order()
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Picker("Select your Juice type", selection: $order.type){
                        ForEach(Order.types.indices)
                        {
                            Text(Order.types[$0])
                        }
                    }
                    Stepper("Number of juices: \(order.quantity)", value: $order.quantity, in: 3...20)
                }
                Section{
                    Toggle("Any Special Requests", isOn: $order.specialRequestEnabled.animation())
                    
                    if order.specialRequestEnabled
                    {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        Toggle("Add extra sprinkes", isOn: $order.addSprinkles)
                    }
                }
                Section{
                    NavigationLink{
                        AddressView(order: order)
                    } label: {
                        Text("Delivery Details")
                    }
                }
            }
            .navigationTitle("Juice Corner")
        }
    }
}

#Preview {
    ContentView()
}
