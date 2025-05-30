//
//  Order.swift
//  JuiceCorner
//
//  Created by Zi on 11/05/2025.
//

import SwiftUI

class Order: ObservableObject, Codable
{
    enum CodingKeys: CodingKey{
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }
    
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
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        
        try container.encode(name, forKey: .name)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
    }
    
    required init(){}
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)
        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        name = try container.decode(String.self, forKey: .name)
        streetAddress = try container.decode(String.self, forKey: .streetAddress)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
    }

}
