//
//  Ingredient+CoreDataProperties.swift
//  Ratatouille
//
//  Created by Victor Falck-Næss on 01/12/2023.
//
//

import Foundation
import CoreData


extension Ingredient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ingredient> {
        return NSFetchRequest<Ingredient>(entityName: "Ingredient")
    }

    @NSManaged public var name: String?
    @NSManaged public var archived: Bool
    @NSManaged public var meal: Meal?

}

extension Ingredient : Identifiable {

}
