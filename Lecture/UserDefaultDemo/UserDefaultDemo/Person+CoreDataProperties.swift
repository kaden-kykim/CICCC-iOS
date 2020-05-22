//
//  Person+CoreDataProperties.swift
//  UserDefaultDemo
//
//  Created by Kaden Kim on 2020-05-22.
//  Copyright © 2020 CICCC. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int32
    @NSManaged public var hobbies: Hobby?

}
