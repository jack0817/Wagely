//
//  WagelyApp.swift
//  Wagely
//
//  Created by Wendell Thompson on 1/13/25.
//

import SwiftUI
import SwiftData

@main
struct WagelyApp: App {
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            Item.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()
    
    @State private var ssot = SSOT()

    var body: some Scene {
        WindowGroup {
            AppView()
                .modifier(ssot)
        }
    }
}
