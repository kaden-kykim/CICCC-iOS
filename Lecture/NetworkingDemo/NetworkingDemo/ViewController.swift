//
//  ViewController.swift
//  NetworkingDemo
//
//  Created by Kaden Kim on 2020-05-14.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 1. url
        let baseURL = URL(string: "https://api.nasa.gov/planetary/apod")!
        
        let queries = [
            "date": "2005-2-22",
            "api_key": "DEMO_KEY"
        ]
        
        let url = baseURL.withQueries(queries)!
        
        // 2. URLSession data task
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let string = String(data: data, encoding: .utf8) {
                print(string)
            }
        }
        
        // 3. resume
        task.resume()
    }

}
