//
//  TodoTableViewController.swift
//  SimpleTodoApp
//
//  Created by Kaden Kim on 2020-05-04.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class TodoTableViewController: UITableViewController {
    
    struct SegueIdentifier {
        static let detailTodo = "DetailTodo"
    }
    
    private let todoCellId = "TodoCell"
    
    private var todos: [[Todo]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        todos.append(dbTodos.filter{ ($0 as Todo).priority == .high })
        todos.append(dbTodos.filter{ ($0 as Todo).priority == .medium })
        todos.append(dbTodos.filter{ ($0 as Todo).priority == .low })
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "High Priority"
        case 1: return "Medium Priority"
        case 2: return "Low Priority"
        default: return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return todos[Priority.high.rawValue].count
        case 1: return todos[Priority.medium.rawValue].count
        case 2: return todos[Priority.low.rawValue].count
        default: return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: todoCellId, for: indexPath) as! TodoTableViewCell
        cell.update(with: todos[indexPath.section][indexPath.row])
        cell.showsReorderControl = true
        return cell
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
    }
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.detailTodo {
            let indexPath = tableView.indexPathForSelectedRow!
            let todo = todos[indexPath.section][indexPath.row]
            let navCtrl = segue.destination as! UINavigationController
            let detailTVC = navCtrl.topViewController as! DetailTodoTableViewController
            detailTVC.setDetailItem(from: todo)
        }
    }
    
    @IBAction func unwindToTodoTableView(segue: UIStoryboardSegue) {}
    
}
