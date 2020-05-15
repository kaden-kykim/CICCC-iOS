import UIKit
import PlaygroundSupport

// Part Two: JSON Serialization

PlaygroundPage.current.needsIndefiniteExecution = true

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}

struct StoreItems: Codable {
    let results: [StoreItem]
}

struct StoreItem: Codable {
    let name: String
    let artist: String
    let kind: String
    let artworkURL: URL
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case name = "trackName"
        case artist = "artistName"
        case kind
        case artworkURL = "artworkUrl100"
        case description
    }
    
    enum AdditionalKeys: String, CodingKey {
        case longDescription
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: CodingKeys.name)
        artist = try values.decode(String.self, forKey: CodingKeys.artist)
        kind = try values.decode(String.self, forKey: CodingKeys.kind)
        artworkURL = try values.decode(URL.self, forKey: CodingKeys.artworkURL)
        
        if let description = try? values.decode(String.self, forKey: CodingKeys.description) {
            self.description = description
        } else {
            let additionalValues = try decoder.container(keyedBy: AdditionalKeys.self)
            description = (try? additionalValues.decode(String.self, forKey: AdditionalKeys.longDescription)) ?? ""
        }
    }
}

func fetchItems(matching query: [String: String], completion: @escaping ([StoreItem]?) -> Void) {
    let baseURL = URL(string: "https://itunes.apple.com/search?")!
    
    guard let url = baseURL.withQueries(query) else {
        completion(nil)
        print("Unable to build URL with supplied queries.")
        return
    }
    
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let data = data, let storeItems = try? JSONDecoder().decode(StoreItems.self, from: data) {
            completion(storeItems.results)
        } else {
            print("Either no data was returned, or data was not serialized.")
            completion(nil)
            return
        }
    }
    
    task.resume()
}


let query: [String: String] = [
    "term": "Frozen",
    "media": "movie",
    "lang": "en_us",
    "limit": "10"
]

fetchItems(matching: query) { (items) in
    if let items = items { print(items) }
    PlaygroundPage.current.finishExecution()
}
