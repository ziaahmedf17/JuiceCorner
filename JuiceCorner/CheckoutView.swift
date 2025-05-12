//
//  CheckoutView.swift
//  JuiceCorner
//
//  Created by Zi on 11/05/2025.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
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
                Button("Place Order")
                {
                    Task
                    {
                        await placeOrder()
                    }
                }
                    .padding()
            }
        }
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank You", isPresented: $showingConfirmation){
            Button("OK"){}
        } message: {
            Text(confirmationMessage)
        }
    }
    func placeOrder() async
    {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        guard let url = URL(string: "https://reqres.in/api/cupcakes") else { return }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do{
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)* \(Order.types[decodedOrder.type].lowercased()) juice is on it's way."
            showingConfirmation = true
        } catch {
            print("Checkout Failed")
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}
