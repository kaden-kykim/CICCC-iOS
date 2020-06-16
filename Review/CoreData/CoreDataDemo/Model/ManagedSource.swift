//
//  ManagedSource.swift
//  CoreData
//
//  Created by Kaden Kim on 2020-06-15.
//  Copyright © 2020 Kaden Kim. All rights reserved.
//

import UIKit
import CoreData

class ManagedSource: NSManagedObject {
    class func findOrCreateSource(matching sourceInfo: Article.Source, in context: NSManagedObjectContext) throws -> ManagedSource {
        let request: NSFetchRequest<ManagedSource> = ManagedSource.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", sourceInfo.name)
        
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                assert(matches.count == 1, "ManagedSource.findOrCreateSource -- database inconsistency")
                return matches[0]
            }
        } catch {
            throw error
        }
        
        // No match, instantiate ManagedSource
        let source = ManagedSource(context: context)
        source.name = sourceInfo.name
        return source
    }
}
