//
//  CoreDataProvider.swift
//  OfflineStorage
//
//  Created by Yogashivasankarri Senthilkumar on 15/01/25.
//

import Foundation
import CoreData

class CoreDataProvider{
    static let shared = CoreDataProvider()
    let persistentContainer: NSPersistentContainer

    private init() {
        ValueTransformer.setValueTransformer(UIColorTransformer(), forName: NSValueTransformerName("UIColorTransformer"))
        persistentContainer = NSPersistentContainer(name: "StorageModel")
        let description = persistentContainer.persistentStoreDescriptions.first
        description?.shouldMigrateStoreAutomatically = true
        description?.shouldInferMappingModelAutomatically = true

        persistentContainer.loadPersistentStores { description, error in
            if let error {
                fatalError("Error initializing StorageModel: \(error)")
            }
        }

    }
}
