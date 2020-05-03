//
//  EmojiTableViewController.swift
//  EmojiDictionary
//
//  Created by Kaden Kim on 2020-05-02.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class EmojiTableViewController: UITableViewController {
    
    struct SegueIdentifier {
      static let addEmoji = "AddEmoji"
      static let editEmoji = "EditEmoji"
    }
    
    private let cellId = "EmojiCell"
    
    var emojis: [Emoji] = [
        Emoji(symbol: "😀", name: "Grinning Face", description: "A typical smiley face.", usage: "happiness"),
        Emoji(symbol: "😕", name: "Confused Face", description: "A confused, puzzled face.", usage: "unsure what to think; displeasure"),
        Emoji(symbol: "😍", name: "Heart Eyes", description: "A smiley face with hearts for eyes. It typically conveys that you love something", usage: "love of something; attractive"),
        Emoji(symbol: "👮", name: "Police Officer", description: "A police officer wearing a blue cap with a gold badge.", usage: "person of authority"),
        Emoji(symbol: "🐢", name: "Turtle", description: "A cute turtle.", usage: "Something slow"),
        Emoji(symbol: "🐘", name: "Elephant", description: "A gray elephant.", usage: "good memory"),
        Emoji(symbol: "🍝", name: "Spaghetti", description: "A plate of spaghetti.", usage: "spaghetti"),
        Emoji(symbol: "🎲", name: "Die", description: "A single die.", usage: "taking a risk, chance; game"),
        Emoji(symbol: "⛺️", name: "Tent", description: "A small tent.", usage: "camping"),
        Emoji(symbol: "📚", name: "Stack of Books", description: "Three colored books stacked on each other.", usage: "homework, studying"),
        Emoji(symbol: "💔", name: "Broken Heart", description: "A red, broken heart.", usage: "extreme sadness"),
        Emoji(symbol: "💤", name: "Snore", description: "Three blue \'z\'s.", usage: "tired, sleepiness"),
        Emoji(symbol: "🏁", name: "Checkered Flag", description: "A black-and-white checkered flag.", usage: "completion")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? emojis.count : 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Step 1: Dequeue cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EmojiTableViewCell
        // Step 2: Fetch model object to display
        let emoji = emojis[indexPath.row]
        // Step 3: Configure cell
        cell.update(with: emoji)
        cell.showsReorderControl = true
        // Step 4: Return cell
        return cell
    }
    
    // MARK: - table view delegate
    
    //    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        let emoji = emojis[indexPath.row]
    //        print("\(emoji.symbol) \(indexPath)")
    //    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedEmoji = emojis.remove(at: fromIndexPath.row)
        emojis.insert(movedEmoji, at: to.row)
        tableView.reloadData()
    }
    
    // Defines left buttons when in editting mode
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
        // Remove the delete indicator
        // return .none
    }
    
    // Override to support editing the table view and swiping to delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            emojis.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    /// Custom row editting buttons
    //    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    //        return UISwipeActionsConfiguration(actions: [
    //            UIContextualAction(style: .destructive, title: "Remove", handler: { [weak self] (action, view, handler)  in
    //                // update the model
    //                self?.emojis.remove(at: indexPath.row)
    //                // update the tableview
    //                tableView.deleteRows(at: [indexPath], with: .automatic)
    //            }),
    //            UIContextualAction(style: .normal, title: "Edit", handler: { (action, view, handler) in
    //                print("Edit")
    //            })
    //        ])
    //    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.editEmoji {
            let indexPath = tableView.indexPathForSelectedRow!
            let emoji = emojis[indexPath.row]
            let navController = segue.destination as! UINavigationController
            let addEditEmojiTableViewController = navController.topViewController as! AddEditEmojiTableViewController
            
            addEditEmojiTableViewController.emoji = emoji
        }
    }
    
    @IBAction func unwindToEmojiTableView(segue: UIStoryboardSegue) {
        guard segue.identifier == AddEditEmojiTableViewController.unwindSegueSaveId,
            let sourceViewController = segue.source as? AddEditEmojiTableViewController,
            let emoji = sourceViewController.emoji
            else { return }
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            emojis[selectedIndexPath.row] = emoji
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
        } else {
            let newIndexPath = IndexPath(row: emojis.count, section: 0)
            emojis.append(emoji)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
}
