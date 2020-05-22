//
//  Hobby+CoreDataProperties.swift
//  UserDefaultDemo
//
//  Created by Kaden Kim on 2020-05-22.
//  Copyright © 2020 CICCC. All rights reserved.
//
//

import Foundation
import CoreData


extension Hobby {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Hobby> {
        return NSFetchRequest<Hobby>(entityName: "Hobby")
    }

    @NSManaged public var name: String?
    @NSManaged public var explanation: String?
    @NSManaged public var cost: Int32
    @NSManaged public var people: Person?

}
