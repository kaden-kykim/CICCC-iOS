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

class NotesViewController: UITableViewController {
    
    private let archiveURL: URL = {
        // 1. access to Documents directory using FileManager
        // Singleton Object: FileManager.default
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("notes_test").appendingPathExtension("plist")
    }()
    
    var notes: [Note] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(NotesTableViewCell.self, forCellReuseIdentifier: "NoteCell")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveNote))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        
        let propertyListDecoder = PropertyListDecoder()
        if let retrievedNoteData = try? Data(contentsOf: archiveURL) {
            if let decodedNote = try? propertyListDecoder.decode([Note].self, from: retrievedNoteData) {
                notes = decodedNote
//                print(decodedNote)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveNotes()
    }
    
    @objc func addNote(_ sender: UIBarButtonItem) {
        let newNote = Note(title: "Grocery Run", text: "Pick up some coconut water", timestamp: Date())
        notes.append(newNote)
        tableView.insertRows(at: [IndexPath(row: notes.count - 1, section: 0)], with: .automatic)
    }
    
    @objc func saveNote(_ sender: UIBarButtonItem) {
        saveNotes()
    }
    
    private func saveNotes() {
        let propertyListEncoder = PropertyListEncoder()
        if let encodedNotes = try? propertyListEncoder.encode(notes) {
            try? encodedNotes.write(to: archiveURL, options: .noFileProtection)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        let note = notes[indexPath.row]
        cell.textLabel?.text = note.title
        cell.detailTextLabel?.text = note.timestamp.description
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
}
