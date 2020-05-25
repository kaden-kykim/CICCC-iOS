//
//  Request.swift
//  NewsAPI
//
//  Created by Derrick Park on 5/24/20.
//  Copyright © 2020 Derrick Park. All rights reserved.
//

import UIKit

// TODO: Need to generate
private let API_KEY = "API_KEY"

struct NewsAPI {
    
    enum EndPoints: String {
        case baseURL = "https://newsapi.org/v2/"
        case topHeadlines = "https://newsapi.org/v2/top-headlines"
        case everything = "https://newsapi.org/v2/everything"
    }
    
    static func getTopHeadlines(with query: String, completion: @escaping (Articles?) -> Void) {
        let url = URL(string: EndPoints.topHeadlines.rawValue)!.withQueries(["q": query, "apiKey": API_KEY, "country": "us"])!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                debugPrint(err.localizedDescription)
                completion(nil)
                return
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let articles = try decoder.decode(Articles.self, from: data)
                    completion(articles)
                } catch {
                    debugPrint(error.localizedDescription)
                }
            }
        }
        
        task.resume()
    }
}
