//
//  OfflineStorageApp.swift
//  OfflineStorage
//
//  Created by Yogashivasankarri Senthilkumar on 15/01/25.
//

import SwiftUI

@main
struct OfflineStorageApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
        }
    }
}
