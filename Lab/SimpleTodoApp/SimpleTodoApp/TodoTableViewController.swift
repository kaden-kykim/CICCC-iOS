//
//  TodoTableViewController.swift
//  SimpleTodoApp
//
//  Created by Kaden Kim on 2020-05-04.
//  Copyright © 2020 CICCC. All rights reserved.
//

import UIKit

class TodoTableViewController: UITableViewController, UIViewControllerTransitioningDelegate {
    
    struct SegueIdentifier {
        static let detailTodo = "DetailTodo"
        static let addTodo = "AddTodo"
        static let editTodo = "EditTodo"
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
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
        return todos[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: todoCellId, for: indexPath) as! TodoTableViewCell
        cell.update(with: todos[indexPath.section][indexPath.row])
        cell.showsReorderControl = true
        return cell
    }
    
    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            UIContextualAction(style: .destructive, title: "Remove", handler: { [weak self] (action, view, handler) in
                // update the model
                self?.todos[indexPath.section].remove(at: indexPath.row)
                // update table view
                tableView.deleteRows(at: [indexPath], with: .automatic)
            })
        ])
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Complete", handler: { [weak self] (action, view, handler) in
            if let complete = self?.todos[indexPath.section][indexPath.row].isCompleted {
                self?.todos[indexPath.section][indexPath.row].isCompleted = !complete
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            
        })
        action.backgroundColor = .green
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.detailTodo {
            let indexPath = tableView.indexPathForSelectedRow!
            let todo = todos[indexPath.section][indexPath.row]
            let navCtrl = segue.destination as! UINavigationController
            let detailTVC = navCtrl.topViewController as! DetailTodoTableViewController
            detailTVC.setDetailItem(from: todo)
        } else if segue.identifier == SegueIdentifier.addTodo {
            let addVC = (segue.destination as! UINavigationController).topViewController as! AddEditTodoTableViewController
            addVC.date = Calendar.current.startOfDay(for: Date()).addingTimeInterval(DAY_IN_SEC)
            addVC.toAdd = true
        }
    }
    
    @IBAction func unwindToTodoTableView(segue: UIStoryboardSegue) {
        guard segue.identifier == AddEditTodoTableViewController.unwindSegueAddEditId,
            let srcVC = segue.source as? AddEditTodoTableViewController, let todo = srcVC.todo
            else { return }
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            todos[selectedIndexPath.section][selectedIndexPath.row] = todo
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
        } else {
            let section = todo.priority.rawValue
            let newIndexPath = IndexPath(row: todos[section].count, section: section)
            todos[section].append(todo)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
}
