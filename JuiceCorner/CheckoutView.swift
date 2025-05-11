//
//  CheckoutView.swift
//  JuiceCorner
//
//  Created by Zi on 11/05/2025.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        ScrollView{
            VStack{
                AsyncImage(url: URL(string: "https://unsplash.com/photos/orange-juice-in-clear-drinking-glass-TmOGarNOGFs"), scale: 3){image in
                        image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your cost is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                Button("Place Order", action: {})
                    .padding()
            }
        }
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    CheckoutView(order: Order())
}
