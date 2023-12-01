//
//  Area+CoreDataProperties.swift
//  Ratatouille
//
//  Created by Victor Falck-Næss on 01/12/2023.
//
//

import Foundation
import CoreData


extension Area {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Area> {
        return NSFetchRequest<Area>(entityName: "Area")
    }

    @NSManaged public var flagName: String?
    @NSManaged public var name: String?
    @NSManaged public var archived: Bool
    @NSManaged public var meal: Meal?

}

extension Area : Identifiable {

}
