//
//  FileUpload+CoreDataProperties.swift.swift
//  OfflineStorage
//
//  Created by Yogashivasankarri Senthilkumar on 15/01/25.
//

import Foundation
import CoreData
import UIKit

extension FileUpload {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FileUpload> {
        return NSFetchRequest<FileUpload>(entityName: "FileUpload")
    }

    @NSManaged public var fileName: String
    @NSManaged public var fileUrl : String
    @NSManaged public var folder: FolderList
}

extension FileUpload : Identifiable {

}
