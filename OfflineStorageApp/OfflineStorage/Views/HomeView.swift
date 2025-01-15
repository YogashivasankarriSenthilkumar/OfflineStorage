//
//  ContentView.swift
//  OfflineStorage
//
//  Created by Yogashivasankarri Senthilkumar on 15/01/25.
//

import SwiftUI
import CoreData

enum SortOption: String, CaseIterable {
    case name = "Name"
    case creationDate = "Creation Date"

    var sortDescriptor: NSSortDescriptor {
        switch self {
        case .name:
            return NSSortDescriptor(key: "name", ascending: true)
        case .creationDate:
            return NSSortDescriptor(key: "creationDate", ascending: true)
        }
    }
}

struct HomeView: View {
    @State private var selectedSortOption: SortOption = .name
    @State private var showSortOptions = false
    @StateObject private var folderFetcher = FolderFetcher()
    @State private var showFavorites = false

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Spacer()

                    Text("Offline Storage")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                    Button(action: {

                        showFavorites.toggle()

                    }) {
                        Image(systemName: "heart.fill")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(showFavorites ? .red : .gray)
                    }
                    .padding(.trailing, 8)

                    Menu {
                        ForEach(SortOption.allCases, id: \.self) { option in
                            Button(option.rawValue) {
                                selectedSortOption = option
                                folderFetcher.updateSortOption(option)
                            }
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.blue)
                    }
                    .padding(.trailing)
                }
                .padding()

                if showFavorites {
                    FolderListView(folderList: folderFetcher.folders.filter { $0.isFavorite })
                } else {
                    FolderListView(folderList: folderFetcher.folders)
                }

                Spacer()

                addFolderButton
            }
            .sheet(isPresented: $folderFetcher.isAddFolderPresented) {
                NavigationStack {
                    AddFolderView { name, color in
                        do {
                            try FolderService.saveFolderList(name, color)
                            folderFetcher.fetchFolders()
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            .onAppear {
                folderFetcher.fetchFolders()
            }
        }
    }

    private var addFolderButton: some View {
        HStack {
            Spacer()
            Button(action: {
                folderFetcher.isAddFolderPresented = true
            }) {
                ZStack {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 60, height: 60)

                    Image(systemName: "plus")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                }
            }
            .padding(.trailing, 20)
            .padding(.bottom, 20)
        }
    }
}


#Preview {
    HomeView()
        .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
}

