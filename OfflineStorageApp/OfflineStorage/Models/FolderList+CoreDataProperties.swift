//
//  FolderList+CoreDataProperties.swift
//  OfflineStorage
//
//  Created by Yogashivasankarri Senthilkumar on 15/01/25.
//

import Foundation
import CoreData
import UIKit

extension FolderList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FolderList> {
        return NSFetchRequest<FolderList>(entityName: "FolderList")
    }

    @NSManaged public var name: String
    @NSManaged public var color: UIColor
    @NSManaged public var isFavorite: Bool
    @NSManaged public var creationDate: Date 
    @NSManaged public var files: NSSet



}

extension FolderList : Identifiable {

}
