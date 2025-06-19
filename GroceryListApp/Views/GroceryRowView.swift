//
//  GroceryRowView.swift
//  GroceryListApp
//
//  Created by Eric Busch on 6/19/25.
//

import SwiftUI

struct GroceryRowView: View {
    @State var groceryItem: GroceryItem
    
    var body: some View {
        HStack {
            Text(groceryItem.itemName)
            if groceryItem.timestampCompleted != nil {
                Spacer()
                Image(systemName: "checkmark")
            }
        }
    }
}

#Preview {
    let groceryItem = GroceryItem(timestamp: Date.now, itemName: "Bread")
    GroceryRowView(groceryItem: groceryItem)
}
