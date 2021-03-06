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

struct PhotoInfo : Codable {
    var title: String
    var description: String
    var url: URL
    var copyright: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case description = "explanation"
        case url
        case copyright
    }
    
    // Below code, no need to implement from Swift 5.0
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try valueContainer.decode(String.self, forKey: CodingKeys.title)
        self.description = try valueContainer.decode(String.self, forKey: CodingKeys.description)
        self.url = try valueContainer.decode(URL.self, forKey: CodingKeys.url)
        self.copyright = try? valueContainer.decode(String.self, forKey: CodingKeys.copyright)
    }
}

struct PhotoInfoAPI {
    static func fetchPhotoInfo(with queries: [String: String], completion: @escaping (PhotoInfo) -> Void) {
        // 1. url
        let baseURL = URL(string: "https://api.nasa.gov/planetary/apod")!
        let url = baseURL.withQueries(queries)!
        
        // 2. URLSession data task
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                if let photoInfo = try? JSONDecoder().decode(PhotoInfo.self, from: data) {
                    // update UI or do somethiing with the data
                    completion(photoInfo)
                }
            }
        }
        
        // 3. resume
        task.resume()
    }
}

class ViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PhotoInfoAPI.fetchPhotoInfo(with: [
            "date": "2005-2-22",
            "api_key": "DEMO_KEY"
        ]) { (photoInfo) in
            // Main thread (update UI)
            DispatchQueue.main.async {
                self.titleLabel.text = photoInfo.title
            }
        }
    }
    
}
