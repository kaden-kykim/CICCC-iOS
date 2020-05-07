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
    
    @IBOutlet var orderByButton: UIBarButtonItem!
    
    private let todoCellId = "TodoCell"
    
    private var todos: [[Todo]] = []
    private var orderByPriority = true
    
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
    
    @IBAction func orderByItemTapped(_ sender: UIBarButtonItem) {
        if orderByPriority {
            var tmpTodos: [Todo] = []
            for todo in todos { tmpTodos.append(contentsOf: todo) }
            todos.removeAll()
            todos.append(tmpTodos.sorted { return ($0 as Todo).deadline < ($1 as Todo).deadline })
        } else {
            let tmpTodos = todos.remove(at: 0)
            todos.removeAll()
            todos.append(tmpTodos.filter{ ($0 as Todo).priority == .high })
            todos.append(tmpTodos.filter{ ($0 as Todo).priority == .medium })
            todos.append(tmpTodos.filter{ ($0 as Todo).priority == .low })
        }
        orderByPriority = !orderByPriority
        orderByButton.image = UIImage.init(systemName: (orderByPriority) ? "line.horizontal.3.decrease.circle" : "line.horizontal.3.decrease.circle.fill")
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return (orderByPriority) ? 3 : 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if orderByPriority {
            return "\(Priority.init(rawValue: section)!.string()) Priority"
        } else {
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos[orderByPriority ? section : 0].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todo = todos[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: todoCellId, for: indexPath) as! TodoTableViewCell
        cell.update(with: todo)
        cell.priorityTextLabel.isHidden = orderByPriority
        cell.showsReorderControl = orderByPriority ? true : false
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return orderByPriority
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            UIContextualAction(style: .destructive, title: "Remove", handler: { [weak self] (action, view, handler) in
                self?.todos[indexPath.section].remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                self?.setEditing(false, animated: false)
                handler(true)
            })
        ])
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let isCompleted = self.todos[indexPath.section][indexPath.row].isCompleted
        let action = UIContextualAction(style: .normal, title: "Complete", handler: { [weak self] (action, view, handler) in
            self?.todos[indexPath.section][indexPath.row].isCompleted = !isCompleted
            self?.setEditing(false, animated: false)
            handler(true)
        })
        action.backgroundColor = (isCompleted) ? .gray : .blue
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    override func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            if !self.isEditing { tableView.reloadData() }
        }
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        if !isEditing { performSegue(withIdentifier: SegueIdentifier.editTodo, sender: indexPath) }
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        var todo = todos[fromIndexPath.section].remove(at: fromIndexPath.row)
        todo.priority = Priority.init(rawValue: to.section)!
        todos[to.section].insert(todo, at: to.row)
        tableView.reloadData()
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
            if selectedIndexPath.section == todo.priority.rawValue {
                todos[selectedIndexPath.section][selectedIndexPath.row] = todo
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                todos[selectedIndexPath.section].remove(at: selectedIndexPath.row)
                todos[todo.priority.rawValue].append(todo)
                tableView.reloadData()
            }
        } else {
            let section = todo.priority.rawValue
            let newIndexPath = IndexPath(row: todos[section].count, section: section)
            todos[section].append(todo)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
    
}
