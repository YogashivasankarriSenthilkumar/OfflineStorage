//
//  FolderService.swift
//  OfflineStorage
//
//  Created by Yogashivasankarri Senthilkumar on 15/01/25.
//

import Foundation
import CoreData
import UIKit

class FolderService{
    static var viewContext: NSManagedObjectContext{
        CoreDataProvider.shared.persistentContainer.viewContext
    }

    static func save() throws{
        try viewContext.save()
    }

    static func saveFolderList(_ name: String, _ color: UIColor) throws{
        let folderList = FolderList(context: viewContext)
        folderList.name = name
        folderList.color = color
        try save()

    }
    static func saveFile(_ fileName: String, _ fileUrl: String, to folder: FolderList) throws {
            let fileUpload = FileUpload(context: viewContext)
            fileUpload.fileName = fileName
            fileUpload.fileUrl = fileUrl
            fileUpload.folder = folder
            try save()
        }
    static func toggleFavorite(for folder: FolderList) throws {
        folder.isFavorite.toggle()
        try save()
    }

}
