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
        let s1 = Student(firstName: "Derrick", lastName: "Park")
        let s2 = Student(firstName: "Andre", lastName: "Majia")
        let s3 = Student(firstName: "Douglas", lastName: "Ciole")
        let s4 = Student(firstName: "Kaden", lastName: "Kim")
        let s5 = Student(firstName: "Wenda", lastName: "Li")
        let s6 = Student(firstName: "Richard", lastName: "Cho")
        let s7 = Student(firstName: "Yusuke", lastName: "Takahashi")
        let s8 = Student(firstName: "Aaron", lastName: "Huang")
        
        print(s1 == s2)
        let students = [s1, s2, s3, s4, s5, s6, s7, s8]
        let sorted = students.sorted(by: <)
        print(sorted)
    }


}

