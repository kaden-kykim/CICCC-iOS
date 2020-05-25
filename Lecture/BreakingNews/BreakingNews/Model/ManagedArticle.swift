//
//  ManagedArticle.swift
//  BreakingNews
//
//  Created by Derrick Park on 5/25/20.
//  Copyright © 2020 Derrick Park. All rights reserved.
//

import UIKit
import CoreData

class ManagedArticle: NSManagedObject {
    class func findOrCreateArticle(matching articleInfo: Article, in context: NSManagedObjectContext) throws -> ManagedArticle {
        let request: NSFetchRequest<ManagedArticle> = ManagedArticle.fetchRequest()
        request.predicate = NSPredicate(format: "title = %@", articleInfo.title)
        // NSSortDescriptor possible
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                assert(matches.count == 1, "ManagedArticle.findOrCreateArticle -- database inconsistency")
                return matches[0]
            }
        } catch {
            throw error
        }
        
        // no match
        let article = ManagedArticle(context: context)
        article.title = articleInfo.title
        article.author = articleInfo.author
        article.url = articleInfo.url
        if let urlStr = articleInfo.urlToImage {
            article.urlToImage = URL(string: urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        }
        article.source = try? ManagedSource.findOrCreateSource(matching: articleInfo.source, in: context)
        return article
    }
}
