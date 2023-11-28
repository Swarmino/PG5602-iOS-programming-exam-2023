//
//  Meal+CoreDataProperties.swift
//  Ratatouille
//
//  Created by Victor Falck-Næss on 28/11/2023.
//
//

import Foundation
import CoreData


extension Meal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Meal> {
        return NSFetchRequest<Meal>(entityName: "Meal")
    }

    @NSManaged public var archived: Bool
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var favourite: Bool
    @NSManaged public var area: NSSet?
    @NSManaged public var category: NSSet?
    @NSManaged public var ingredient: NSSet?

}

// MARK: Generated accessors for area
extension Meal {

    @objc(addAreaObject:)
    @NSManaged public func addToArea(_ value: Area)

    @objc(removeAreaObject:)
    @NSManaged public func removeFromArea(_ value: Area)

    @objc(addArea:)
    @NSManaged public func addToArea(_ values: NSSet)

    @objc(removeArea:)
    @NSManaged public func removeFromArea(_ values: NSSet)

}

// MARK: Generated accessors for category
extension Meal {

    @objc(addCategoryObject:)
    @NSManaged public func addToCategory(_ value: Category)

    @objc(removeCategoryObject:)
    @NSManaged public func removeFromCategory(_ value: Category)

    @objc(addCategory:)
    @NSManaged public func addToCategory(_ values: NSSet)

    @objc(removeCategory:)
    @NSManaged public func removeFromCategory(_ values: NSSet)

}

// MARK: Generated accessors for ingredient
extension Meal {

    @objc(addIngredientObject:)
    @NSManaged public func addToIngredient(_ value: Ingredient)

    @objc(removeIngredientObject:)
    @NSManaged public func removeFromIngredient(_ value: Ingredient)

    @objc(addIngredient:)
    @NSManaged public func addToIngredient(_ values: NSSet)

    @objc(removeIngredient:)
    @NSManaged public func removeFromIngredient(_ values: NSSet)

}

extension Meal : Identifiable {

}

