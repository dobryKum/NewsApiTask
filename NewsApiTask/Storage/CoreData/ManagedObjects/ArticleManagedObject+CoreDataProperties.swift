//
//  ArticleManagedObject+CoreDataProperties.swift
//  NewsApiTask
//
//  Created by Tsimafei Zykau on 8.05.23.
//
//

import Foundation
import CoreData


extension ArticleManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArticleManagedObject> {
        return NSFetchRequest<ArticleManagedObject>(entityName: "ArticleManagedObject")
    }

    @NSManaged public var title: String
    @NSManaged public var subtitle: String?
    @NSManaged public var imagePath: String?
    @NSManaged public var author: String?
    @NSManaged public var content: String?
    @NSManaged public var url: URL?

}

extension ArticleManagedObject : Identifiable {

}
