//
//  ViewController.swift
//  ProtocolPersistence
//
//  Created by Kaden Kim on 2020-05-05.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

struct Student : Equatable, Comparable, CustomStringConvertible, Codable {
    var firstName: String
    var lastName: String
    var description: String {
        return "\(firstName) \(lastName)"
    }
    
    static func ==(lhs: Student, rhs: Student) -> Bool {
        return lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName
    }
    
    static func <(lhs: Student, rhs: Student) -> Bool {
        return lhs.lastName < rhs.lastName
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
//        let s1 = Student(firstName: "Derrick", lastName: "Park")
//        let s2 = Student(firstName: "Andre", lastName: "Majia")
//        let s3 = Student(firstName: "Douglas", lastName: "Ciole")
//        let s4 = Student(firstName: "Kaden", lastName: "Kim")
//        let s5 = Student(firstName: "Wenda", lastName: "Li")
//        let s6 = Student(firstName: "Richard", lastName: "Cho")
//        let s7 = Student(firstName: "Yusuke", lastName: "Takahashi")
//        let s8 = Student(firstName: "Aaron", lastName: "Huang")
//
//        print(s1 == s2)
//        let students = [s1, s2, s3, s4, s5, s6, s7, s8]
//        let sorted = students.sorted(by: <)
//        print(sorted)
        
//        // Encode s1 into JSON
//        // 1. create an encoder
//        let jsonEncoder = JSONEncoder()
//        // 2. encode -> Data: a bag of bits
//        if let encodedJson = try? jsonEncoder.encode(s1) {
//            print(String(data: encodedJson, encoding: .utf8)!)
//
//            // Decode encodedJson into Student object
//            // 1. create a decoder
//            let jsonDecoder = JSONDecoder()
//            // 2. decode
//            do {
//                let obj = try jsonDecoder.decode(Student.self, from: encodedJson)
//                print(obj)
//            } catch (let err) {
//                // except declaring the error argument, 'error' is default one
//                print(err.localizedDescription)
//            }
//        }
        fetchStarwarsCharacter("https://swapi.dev/api/people/1/")
    }
    
    private func fetchStarwarsCharacter(_ urlString: String) {
        // 1. create an url object
        guard let url = URL(string: urlString) else { return }
        // 2. URLSession
        let session = URLSession(configuration: .default)
        // 3. create a task
        let task = session.dataTask(with: url) { (data, res, err) in
            guard err == nil else { return }
            guard let data = data else { return }
            if let swChar = try? JSONDecoder().decode(StarWarsChar.self, from: data) {
                print(swChar)
            }
        }
        // 4. fire off
        task.resume()
    }
    
}

struct StarWarsChar : Codable, CustomStringConvertible {
    let name: String
    let eye_color: String
    let gender: String
    var description: String {
        return "\(name)"
    }
}
