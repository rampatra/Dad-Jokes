//
//  Joke+CoreDataProperties.swift
//  Dad Jokes
//
//  Created by Ram Patra on 20/03/2020.
//  Copyright © 2020 Ram Patra. All rights reserved.
//
//

import Foundation
import CoreData


extension Joke {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Joke> {
        return NSFetchRequest<Joke>(entityName: "Joke")
    }

    @NSManaged public var setup: String
    @NSManaged public var punchline: String
    @NSManaged public var rating: String

}
