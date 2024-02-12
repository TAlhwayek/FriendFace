//
//  Friend.swift
//  Challenge #5
//
//  Created by Tony Alhwayek on 2/10/24.
//

import Foundation
import SwiftData

@Model
class Friend: Codable, Identifiable {
    let id: UUID
    let name: String
}
