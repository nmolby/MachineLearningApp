//
//  MachineLearningApp.swift
//  Shared
//
//  Created by Nathan Molby on 1/8/22.
//

import SwiftUI

@main
struct MachineLearningApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
