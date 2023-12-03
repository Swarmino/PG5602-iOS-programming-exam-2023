//
//  Category+CoreDataProperties.swift
//  Ratatouille
//
//  Created by Victor Falck-Næss on 01/12/2023.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var name: String?
    @NSManaged public var archived: Bool
    @NSManaged public var meal: Meal?

}

extension Category : Identifiable {

}