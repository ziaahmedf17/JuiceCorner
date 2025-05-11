//
//  Order.swift
//  JuiceCorner
//
//  Created by Zi on 11/05/2025.
//

import SwiftUI

class Order: ObservableObject
{
    static let types = ["Mango", "Strawberry","Pine Apple", "Grapes", "Orange"]
    
    @Published var type = 0
    @Published var quantity = 3
    
    @Published var specialRequestEnabled = false{
        didSet{
            if specialRequestEnabled == false{
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    
}
