//
//  FolderFetcher.swift
//  OfflineStorage
//
//  Created by Yogashivasankarri Senthilkumar on 15/01/25.
//

import SwiftUI
import CoreData


class FolderFetcher: ObservableObject {
    @Published var folders: [FolderList] = []
    @Published var isAddFolderPresented = false
    private let context = CoreDataProvider.shared.persistentContainer.viewContext
    private var sortDescriptor: NSSortDescriptor = SortOption.name.sortDescriptor

    init() {
        fetchFolders()
    }

    func fetchFolders() {
            let fetchRequest: NSFetchRequest<FolderList> = FolderList.fetchRequest()
            fetchRequest.sortDescriptors = [sortDescriptor]
            do {
                folders = try context.fetch(fetchRequest)
            } catch {
                print("Failed to fetch folders: \(error)")
            }
    }

    func updateSortOption(_ sortOption: SortOption) {
        sortDescriptor = sortOption.sortDescriptor
        fetchFolders()
    }
}

