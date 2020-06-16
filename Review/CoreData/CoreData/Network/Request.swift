//
//  Request.swift
//  CoreData
//
//  Created by Kaden Kim on 2020-06-15.
//  Copyright © 2020 Kaden Kim. All rights reserved.
//

import UIKit

private let API_KEY = newsApiKey

struct NewsAPI {
    
    enum EndPoints: String {
        case baseURL = "https://newsapi.org/v2/"
        case topHeadlines = "https://newsapi.org/v2/top-headlines"
        case everything = "https://newsapi.org/v2/everything"
    }
    
    static func getTopHeadlines(with query: String, completion: @escaping (Articles?) -> Void) {
        let url = URL(string: EndPoints.topHeadlines.rawValue)!.withQueries(["q": query, "apiKey": API_KEY, "country": "us"])!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let error = err {
                debugPrint(error.localizedDescription)
                completion(nil)
                return
            }
            
            if let data = data {
                do {
                    let articles = try JSONDecoder().decode(Articles.self, from: data)
                    completion(articles)
                } catch {
                    debugPrint(error.localizedDescription)
                }
            }
        }
        
        task.resume()
    }
}
