//
//  AddGroceryItemView.swift
//  GroceryListApp
//
//  Created by Eric Busch on 6/19/25.
//

import SwiftUI

struct AddGroceryItemView: View {
    var onAdd: (GroceryItem) -> Void
    var onDone: () -> Void
    @State private var name = ""
    @State private var previousName = ""
    @State private var showingAdded = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    TextField("Enter the grocery item name", text: $name, onCommit: addGroceryItem)
                }
                if showingAdded {
                    Text("Added \(previousName)!")
                }
            }
            .navigationTitle("Add An Item")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done", action: onDone)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add", action: addGroceryItem)
                        .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
    
    /// Adds the grocery item from the current text.
    func addGroceryItem() {
        let newItem = GroceryItem(timestamp: Date.now, itemName: name)
        onAdd(newItem)
        
        // Set the previous name so we can show a little confirmation dialog.
        previousName = name
        name = ""
        
        // Animate the confirmation dialog in.
        withAnimation {
            showingAdded = true
        }
    
        // Only show that confirmation dialog for a couple seconds.
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation {
                showingAdded = false
            }
        }
    }
}

#Preview {
    AddGroceryItemView(onAdd: { GroceryItem in
        
    }, onDone: {
        
    })
}
