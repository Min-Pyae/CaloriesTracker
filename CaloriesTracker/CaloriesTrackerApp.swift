//
//  CaloriesTrackerApp.swift
//  CaloriesTracker
//
//  Created by Chris Min on 12/04/2024.
//

import SwiftUI

@main
struct CaloriesTrackerApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
