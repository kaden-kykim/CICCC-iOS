//
//  ManagedArticle.swift
//  CoreData
//
//  Created by Kaden Kim on 2020-06-15.
//  Copyright © 2020 Kaden Kim. All rights reserved.
//

import UIKit
import CoreData

class ManagedArticle: NSManagedObject {
    class func findOrCreateArticle(matching articleInfo: Article, with searchText: String, in context: NSManagedObjectContext) throws -> ManagedArticle {
        let request: NSFetchRequest<ManagedArticle> = ManagedArticle.fetchRequest()
        request.predicate = NSPredicate(format: "title = %@", articleInfo.title)
        // Possible to add: NSSortDescriptor for sorting result
        
        do {
            let matches = try context.fetch(request)
            if matches.count > 0 {
                assert(matches.count == 1, "ManagedArticle.findOrCreateArticle - database inconsistency")
                let matchedArticle = matches[0]
                matchedArticle.searchText = searchText
                return matchedArticle
            }
        } catch {
            throw error
        }
        
        // No match, instantiate ManagedArticle
        let article = ManagedArticle(context: context)
        article.title = articleInfo.title
        article.author = articleInfo.author
        article.url = articleInfo.url
        article.searchText = searchText
        if let urlStr = articleInfo.urlToImage {
            article.urlToImage = URL(string: urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        }
        article.source = try? ManagedSource.findOrCreateSource(matching: articleInfo.source, in: context)
        return article
    }
}
