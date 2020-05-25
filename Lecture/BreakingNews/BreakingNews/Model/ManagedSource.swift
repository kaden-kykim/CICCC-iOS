//
//  ManagedSource.swift
//  BreakingNews
//
//  Created by Derrick Park on 5/25/20.
//  Copyright © 2020 Derrick Park. All rights reserved.
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
                // assert 'sanity': if condition false ... then print message and interrupt program
                assert(matches.count == 1, "ManagedSource.findOrCreateSource -- database inconsistency")
                return matches[0]
            }
        } catch {
            throw error
        }
        // no match, instantiate ManagedSource
        let source = ManagedSource(context: context)
        source.name = sourceInfo.name
        return source
    }
    
}
