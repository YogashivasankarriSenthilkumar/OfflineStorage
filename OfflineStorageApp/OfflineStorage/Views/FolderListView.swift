//
//  FolderListView.swift
//  OfflineStorage
//
//  Created by Yogashivasankarri Senthilkumar on 15/01/25.
//


import SwiftUI
import CoreData

struct FolderListView: View {
    let folderList: [FolderList]
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    @State private var favoriteStatus: [NSManagedObjectID: Bool] = [:]

    var body: some View {
        if folderList.isEmpty {
            VStack {
                Spacer()
                Text("No Folders Found")
                    .font(.headline)
                    .foregroundColor(.gray)
                Spacer()
            }
        } else {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(folderList, id: \.self) { folder in
                        ZStack(alignment: .topTrailing) {
                            NavigationLink(destination: FolderDetailView(folder: folder)) {
                                FolderCellView(folder: folder)
                            }

                            Button(action: {
                                let newStatus = !(favoriteStatus[folder.objectID] ?? folder.isFavorite)
                                    favoriteStatus[folder.objectID] = newStatus
                                    toggleFavorite(folder: folder, isFavorite: newStatus)
                            }) {
                                Image(systemName: (favoriteStatus[folder.objectID] ?? folder.isFavorite) ? "heart.fill" : "heart")
                                            .font(.system(size: 20))
                                            .foregroundColor((favoriteStatus[folder.objectID] ?? folder.isFavorite) ? .red : .gray)
                                            .padding(8)
                            }
                        }
                    }
                }
                .padding()
            }
        }
    }

    private func toggleFavorite(folder: FolderList, isFavorite: Bool) {
        do {
            folder.isFavorite = isFavorite
            try FolderService.save()
        } catch {
            print("Failed to toggle favorite: \(error)")
        }
    }
}
