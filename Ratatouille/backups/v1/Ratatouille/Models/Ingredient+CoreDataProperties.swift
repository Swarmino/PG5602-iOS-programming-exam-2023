//
//  Ingredient+CoreDataProperties.swift
//  Ratatouille
//
//  Created by Victor Falck-Næss on 25/11/2023.
//
//

import Foundation
import CoreData


extension Ingredient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ingredient> {
        return NSFetchRequest<Ingredient>(entityName: "Ingredient")
    }

    @NSManaged public var name: String?
    @NSManaged public var meal: NSSet?

}

// MARK: Generated accessors for meal
extension Ingredient {

    @objc(addMealObject:)
    @NSManaged public func addToMeal(_ value: Meal)

    @objc(removeMealObject:)
    @NSManaged public func removeFromMeal(_ value: Meal)

    @objc(addMeal:)
    @NSManaged public func addToMeal(_ values: NSSet)

    @objc(removeMeal:)
    @NSManaged public func removeFromMeal(_ values: NSSet)

}

extension Ingredient : Identifiable {

}
