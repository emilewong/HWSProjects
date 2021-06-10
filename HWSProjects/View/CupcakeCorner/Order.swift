//
//  Order.swift
//  HWSProjects
//
//  Created by Emile Wong on 8/6/2021.
//

import Foundation

class Order: ObservableObject, Codable {
    // MARK: - PROPERTIES
    enum CodingKeys: CodingKey {
        case type, quantity, specialRequestEnabled, extraForsting, addSprinkles, name, streetAddress, city, zip
    }
    static let types = ["Vanilla", "Strawbery", "Chocolate", "Rainbow"]
    
    @Published var type = 0
    @Published var quantity = 3
    
    @Published var specialRequestEnabled = false {
        didSet{
            if specialRequestEnabled == false {
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
    
    // MARK: - COMPUTED PROPERTIES
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        } else if self.isBlank(name) || self.isBlank(streetAddress) || self.isBlank(city) || self.isBlank(zip){
                return false
        }
        return true
    }
    
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2
        
        // complicated cakes cost more
        cost += Double(type) / 2
        
        // $1/cake for extra frosting
        if extraFrosting{
            cost += Double(quantity)
        }
        // $0.50/cake for sprinkles
        if addSprinkles{
            cost += Double(quantity) / 2
        }
        return cost
    }
    
    // MARK: - INITIALIZERS
    init () {}
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)
        
        extraFrosting = try container.decode(Bool.self, forKey: .extraForsting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        
        name = try container.decode(String.self, forKey: .name)
        streetAddress = try container.decode(String.self, forKey: .streetAddress)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
    }
    
    // MARK: - FUNCITONS
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        
        try container.encode(specialRequestEnabled, forKey: .specialRequestEnabled)
        try container.encode(extraFrosting, forKey: .extraForsting)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        
        try container.encode(name, forKey: .name)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
    }
    
    func isBlank(_ string: String) -> Bool {
        for character in string {
            if !character.isWhitespace {
                return false
            }
        }
        return true
    }
    
}
