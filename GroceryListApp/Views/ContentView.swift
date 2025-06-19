//
//  ContentView.swift
//  GroceryListApp
//
//  Created by Eric Busch on 6/19/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var allItems: [GroceryItem]
    @State private var showingAddItemModal = false
    @State private var showingCompletedItems = true
    
    // Items that are not yet completed should be kept separately from those that are.
    private var groceryItemGroups: [GroceryItemGroup] {
        let pendingItems = allItems.filter { $0.timestampCompleted == nil }
        let completedItems = allItems.filter { $0.timestampCompleted != nil }

        var groups = [GroceryItemGroup(name: "Incomplete", groceryItems: pendingItems)]

        if showingCompletedItems {
            groups.append(GroceryItemGroup(name: "Completed Items", groceryItems: completedItems))
        }

        return groups
    }

    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(groceryItemGroups, id: \.self) { group in
                        Section(header: Text(group.name)) {
                            ForEach(group.groceryItems) { groceryItem in
                                Button {
                                    if groceryItem.timestampCompleted == nil {
                                        groceryItem.timestampCompleted = Date.now
                                    } else {
                                        groceryItem.timestampCompleted = nil
                                    }
                                } label: {
                                    GroceryRowView(groceryItem: groceryItem)
                                }
                            }
                            .onDelete(perform: deleteItems)
                        }
                    }
                }
                
                // If there isn't any content currently showing, we should display a message for the user.
                if groceryItemGroups.allSatisfy({ $0.groceryItems.isEmpty }) {
                    Text("Please add a grocery item using the '+' symbol above.")
                        .foregroundColor(.secondary)
                        .font(.title3)
                        .multilineTextAlignment(.center)
                }
            }
            .navigationBarTitleDisplayMode(.large)
            .navigationTitle("Groceries")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showingCompletedItems.toggle()
                    } label: {
                        showingCompletedItems ?
                            Image(systemName: "line.3.horizontal.decrease.circle") :
                            Image(systemName: "line.3.horizontal.decrease.circle.fill")
                    }
                }
                ToolbarItem {
                    Button(action: showAddItemsView) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddItemModal) {
                AddGroceryItemView(onAdd: addItem, onDone: doneAddingItems)
            }
        }
    }
    
    private func showAddItemsView() {
        showingAddItemModal = true
    }

    private func addItem(groceryItem: GroceryItem) {
        withAnimation {
            modelContext.insert(groceryItem)
        }
    }
    
    private func doneAddingItems() {
        showingAddItemModal = false
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(allItems[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: GroceryItem.self, inMemory: true)
}
