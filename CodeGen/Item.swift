//
//  Item.swift
//  CodeGen
//
//  Created by Kyle Ferrigan on 3/8/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
