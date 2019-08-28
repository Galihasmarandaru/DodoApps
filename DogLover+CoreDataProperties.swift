//
//  DogLover+CoreDataProperties.swift
//  
//
//  Created by Galih Asmarandaru on 28/08/19.
//
//

import Foundation
import CoreData


extension DogLover {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DogLover> {
        return NSFetchRequest<DogLover>(entityName: "DogLover")
    }

    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: String?

}
