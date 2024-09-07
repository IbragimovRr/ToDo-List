//
//  Todo+CoreDataProperties.swift
//  ToDo List
//
//  Created by Руслан on 08.09.2024.
//
//

import Foundation
import CoreData


extension Todo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo")
    }

    @NSManaged public var id: Int64
    @NSManaged public var text: String?
    @NSManaged public var descriptionText: String?
    @NSManaged public var completed: Bool
    @NSManaged public var userID: Int64
    @NSManaged public var date: Date

}

extension Todo : Identifiable {

}
