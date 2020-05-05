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
        if let _ = try? propertyListEncoder.encode(newNote) {
            // 1. access to Documents directory using FileManager
            // Singleton Object: FileManager.default
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let archiveURL = documentDirectory.appendingPathComponent("notes_test").appendingPathExtension("plist")
            
//            try? encodedNote.write(to: archiveURL, options: .noFileProtection)
            
            let propertyListDecoder = PropertyListDecoder()
            if let retrievedNoteData = try? Data(contentsOf: archiveURL) {
                if let decodedNote = try? propertyListDecoder.decode(Note.self, from: retrievedNoteData) {
                    print(decodedNote)
                }
            }
        }
    }
    
}
