//
//  GroceryListAppApp.swift
//  GroceryListApp
//
//  Created by Eric Busch on 6/19/25.
//

import SwiftUI
import SwiftData

@main
struct GroceryListAppApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            GroceryItem.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
