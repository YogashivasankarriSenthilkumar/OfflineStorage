//
//  FolderCellView.swift
//  OfflineStorage
//
//  Created by Yogashivasankarri Senthilkumar on 15/01/25.
//

import Foundation
import SwiftUI

struct FolderCellView: View {
    let folder: FolderList
    @State private var isFavorite: Bool

    init(folder: FolderList) {
        self.folder = folder
        _isFavorite = State(initialValue: folder.isFavorite)
    }

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(folder.color))
                    .aspectRatio(1, contentMode: .fit)
                    .shadow(radius: 5)

                Image(systemName: "folder")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.white)
            }

            Text(folder.name)
                .font(.caption)
                .lineLimit(1)
        }
        .frame(width: 100)
    }

    private func toggleFavorite() {
        isFavorite.toggle()
        folder.isFavorite = isFavorite
        try? FolderService.save()
    }
}
