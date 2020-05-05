//
//  NotesViewController.swift
//  ProtocolPersistence
//
//  Created by Kaden Kim on 2020-05-05.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

// plist: Property List
struct Note : Codable{
    let title: String
    let text: String
    let timestamp: Date
}

class NotesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        let newNote = Note(title: "Grocery Run", text: "Pick up some coconut water", timestamp: Date())
        // Object to Property list
        let propertyListEncoder = PropertyListEncoder()
        if let encodedNote = try? propertyListEncoder.encode(newNote) {
            print(encodedNote)
            
            let propertyListDecoder = PropertyListDecoder()
            if let decodedNote = try? propertyListDecoder.decode(Note.self, from: encodedNote) {
                print(decodedNote)
            }
        }
    }
    
}
