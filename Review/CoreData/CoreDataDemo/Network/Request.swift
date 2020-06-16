//
//  Request.swift
//  CoreData
//
//  Created by Kaden Kim on 2020-06-15.
//  Copyright © 2020 Kaden Kim. All rights reserved.
//

import UIKit

private let API_KEY = newsApiKey

class NewsAPIRequest {
    
    static let shared = NewsAPIRequest()

    private var dataTask: URLSessionDataTask?
    
    private init() {}
    
    func getTopHeadlines(with query: String, completion: @escaping (Articles?) -> Void) {
        let url = URL(string: EndPoints.topHeadlines)!
            .withQueries(
                [Parameters.q: query,
                 Parameters.apiKey: API_KEY,
                 Parameters.country: "us"])!
        
        fetch(from: url) { (articles: Articles?, err: Error?) in
            if let err = err {
                debugPrint(err.localizedDescription)
                completion(nil)
                return
            }
            completion(articles)
        }
    }
    
    func fetch<T: Decodable>(from url: URL, completion: @escaping (T?, Error?) -> ()) {
        dataTask?.cancel()
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                debugPrint("Client error! - \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode) else {
                debugPrint("Server error!")
                completion(nil, error)
                return
            }
            
            do {
                guard let data = data else {
                    debugPrint("Client error! - data is nil")
                    completion(nil, error)
                    return
                }
                let decodable = try JSONDecoder().decode(T.self, from: data)
                completion(decodable, nil)
            } catch {
                debugPrint("JSON error: \(error.localizedDescription)")
                completion(nil, error)
            }
        }
         
        dataTask?.resume()
    }
    
    struct EndPoints {
        static let baseURL = "https://newsapi.org/v2/"
        static let topHeadlines = "https://newsapi.org/v2/top-headlines"
        static let everything = "https://newsapi.org/v2/everything"
    }
    
    struct Parameters {
        static let q = "q"
        static let apiKey = "apikey"
        static let country = "country"
    }
}
