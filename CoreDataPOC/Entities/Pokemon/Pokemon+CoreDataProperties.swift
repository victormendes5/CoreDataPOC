//
//  Pokemon+CoreDataProperties.swift
//  
//
//  Created by João Mendes | Stone on 20/08/18.
//
//

import Foundation
import CoreData


extension Pokemon {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pokemon> {
        return NSFetchRequest<Pokemon>(entityName: "Pokemon")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?

}
