//
//  GroceryItem.swift
//  GroceryListApp
//
//  Created by Eric Busch on 6/19/25.
//

import Foundation
import SwiftData

/// A grocery item.
@Model
final class GroceryItem {
    var timestampAdded: Date
    var timestampCompleted: Date?
    var itemName: String
    
    init(timestamp: Date, itemName: String) {
        self.timestampAdded = timestamp
        self.itemName = itemName
    }
}
