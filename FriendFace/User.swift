//
//  User.swift
//  Challenge #5
//
//  Created by Tony Alhwayek on 2/10/24.
//

import Foundation
import SwiftData

@Model
class User: Codable, Identifiable {
    enum CodingKeys: CodingKey {
        case id, isActive, name, age, company, email, address, about, registered, tags, friends
    }
    
    let id: UUID
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: String
    let tags: [String]
    let friends: [Friend]
    
    init(id: UUID, isActive: Bool, name: String, age: Int, company: String, email: String, address: String, about: String, registered: String, tags: [String], friends: [Friend]) {
        self.id = id
        self.isActive = isActive
        self.name = name
        self.age = age
        self.company = company
        self.email = email
        self.address = address
        self.about = about
        self.registered = registered
        self.tags = tags
        self.friends = friends
    }
    
    var fixedDate: String {
        let isoFormatter = ISO8601DateFormatter()
        let date = isoFormatter.date(from: registered) ?? .now
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        return dateFormatter.string(from: date)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id            = try container.decode(UUID.self, forKey: .id)
        isActive      = try container.decode(Bool.self, forKey: .isActive)
        name          = try container.decode(String.self, forKey: .name)
        company       = try container.decode(String.self, forKey: .company)
        email         = try container.decode(String.self, forKey: .email)
        address       = try container.decode(String.self, forKey: .address)
        about         = try container.decode(String.self, forKey: .about)
        registered    = try container.decode(String.self, forKey: .registered)
        tags          = try container.decode([String].self, forKey: .tags)
        friends       = try container.decode([Friend].self, forKey: .friends)
    }
    
    
    
}
