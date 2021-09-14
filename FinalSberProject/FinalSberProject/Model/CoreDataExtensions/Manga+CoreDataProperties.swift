//
//  Manga+CoreDataProperties.swift
//  FinalSberProject
//
//  Created by Виктор Поволоцкий on 29.08.2021.
//
//

import Foundation
import CoreData

extension LocalManga {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocalManga> {
        return NSFetchRequest<LocalManga>(entityName: "Manga")
    }

    @NSManaged public var name: String?
    @NSManaged public var code: String?
    @NSManaged public var descriptions: String?
    @NSManaged public var cover: String?
    @NSManaged public var raiting: String?
    @NSManaged public var chapters: Int16
    @NSManaged public var tags: String?

}

extension LocalManga: Identifiable {

}
