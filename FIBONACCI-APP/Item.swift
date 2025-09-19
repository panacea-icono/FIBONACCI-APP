//
//  Item.swift
//  FIBONACCI-APP
//
//  Created by Nuevo Usuario on 18/9/25.
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
