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
        let todo = todos[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: todoCellId, for: indexPath) as! TodoTableViewCell
        cell.update(with: todo)
        cell.showsReorderControl = true
        return cell
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            UIContextualAction(style: .destructive, title: "Remove", handler: { [weak self] (action, view, handler) in
                self?.todos[indexPath.section].remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                handler(true)
            })
        ])
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let isCompleted = self.todos[indexPath.section][indexPath.row].isCompleted
        let action = UIContextualAction(style: .normal, title: "Complete", handler: { [weak self] (action, view, handler) in
            self?.todos[indexPath.section][indexPath.row].isCompleted = !isCompleted
            handler(true)
        })
        action.backgroundColor = (isCompleted) ? .gray : .blue
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    override func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        setEditing(false, animated: false)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        if !isEditing {
            performSegue(withIdentifier: SegueIdentifier.editTodo, sender: indexPath)
        }
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
        } else if segue.identifier == SegueIdentifier.editTodo {
            guard let indexPath = sender as? IndexPath else { return }
            let editVC = (segue.destination as! UINavigationController).topViewController as! AddEditTodoTableViewController
            editVC.selectedIndexPath = indexPath
            editVC.todo = todos[indexPath.section][indexPath.row]
        }
    }
    
    @IBAction func unwindToTodoTableView(segue: UIStoryboardSegue) {
        guard segue.identifier == AddEditTodoTableViewController.unwindSegueAddEditId,
            let srcVC = segue.source as? AddEditTodoTableViewController, let todo = srcVC.todo
            else { return }
        if let selectedIndexPath = srcVC.selectedIndexPath {
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
