//
//  GroceryItemGroup.swift
//  GroceryListApp
//
//  Created by Eric Busch on 6/19/25.
//

import SafariServices
import SwiftUI
import SwiftData

///  This group allows for easier separating of items that are and are not completed.
struct GroceryItemGroup: Hashable, Identifiable {
    let name: String
    let groceryItems: [GroceryItem]
    let id = UUID()
}
