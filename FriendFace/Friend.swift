//
//  Friend.swift
//  Challenge #5
//
//  Created by Tony Alhwayek on 2/10/24.
//

import Foundation
import SwiftData

@Model
class Friend: Codable {
    enum CodingKeys: CodingKey {
        case id, name
    }
    
    var id: UUID
    var name: String
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id            = try container.decode(UUID.self, forKey: .id)
        name          = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id,   forKey: .id)
        try container.encode(name, forKey: .name)
    }
}
