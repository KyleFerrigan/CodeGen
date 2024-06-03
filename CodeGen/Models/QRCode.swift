//
//  Item.swift
//  CodeGen
//
//  Created by Kyle Ferrigan on 3/8/24.
//

import Foundation
import SwiftData

@Model
final class QRCode {
    
    var timestamp: Date?
    var data: String?
    var position: Int?
    
    init(data: String, position: Int) {
        self.timestamp = Date()
        self.data = data
        self.position = position
    }
}
