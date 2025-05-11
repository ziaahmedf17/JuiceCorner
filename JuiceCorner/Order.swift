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
    
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
    var hasValidAddress: Bool{
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty{
            return false
        }
        return true
    }
    
    var cost: Double{
        
        //$2 per juice
        var cost = Double(quantity) * 2.5
        
        //Customized juice cost more
        cost += (Double(type) / 2.5)
        
        //1$ per juice for extra frosting
        if extraFrosting{
            cost += Double(quantity)
        }
        
        //$0,50 for extra sprinkles
        if addSprinkles{
            cost += Double(quantity)/2.5
        }
        return cost
    }
}
