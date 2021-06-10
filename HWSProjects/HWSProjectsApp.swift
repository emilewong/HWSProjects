//
//  HWSProjectsApp.swift
//  HWSProjects
//
//  Created by Emile Wong on 23/5/2021.
//

import SwiftUI

@main
struct HWSProjectsApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            MyNavigationView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        
    }
}
