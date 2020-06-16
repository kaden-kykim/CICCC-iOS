//
//  SourcesTableViewController.swift
//  CoreDataDemo
//
//  Created by Kaden Kim on 2020-06-15.
//  Copyright © 2020 Kaden Kim. All rights reserved.
//

import UIKit
import CoreData

// 1. create a NSFetchedResultController (with predicate, sort descriptor, ...)
// 2. frc.delegate = self

class SourcesTableViewController: FetchedResultsTableViewController {

    private let cellId = "SourceCell"

    private lazy var fetchedResultController: NSFetchedResultsController<ManagedSource> = {
        let request: NSFetchRequest<ManagedSource> = ManagedSource.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))]
        request.predicate = NSPredicate(format: "ANY articles.searchText CONTAINS[c] %@", searchText)
        
        let frc = NSFetchedResultsController<ManagedSource>(
            fetchRequest: request,
            managedObjectContext: container.viewContext,
            sectionNameKeyPath: "firstLetter",
            cacheName: nil) // It's going to permanently cache the results (stores on disk in some internal format)
                            // Be sure that any cacheName you use is always associated with exactly the same request
                            // You'll have to invalidate the cache if you change anything about the request. (There's an API for it)
        frc.delegate = self
        return frc
    }()
    
    var searchText: String! { didSet { updateUI() } }
    
    private var container: NSPersistentContainer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sources for \(searchText!)"
        tableView.register(SourceCell.self, forCellReuseIdentifier: cellId)
    }
    
    private func updateUI() {
        try? fetchedResultController.performFetch()
        tableView.reloadData()
    }
    
    private func sourceCountWithSearchText(by source: ManagedSource) -> Int {
        let request: NSFetchRequest<ManagedArticle> = ManagedArticle.fetchRequest()
        request.predicate = NSPredicate(format: "searchText CONTAINS[c] %@ AND source == %@", searchText, source)
        return (try? source.managedObjectContext!.count(for: request)) ?? 0
    }
    
    override init(style: UITableView.Style) {
        super.init(style: style)
    }
    
    convenience init(_ container: NSPersistentContainer) {
        self.init(style: .plain)
        self.container = container
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - table view data source
extension SourcesTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultController.sections?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultController.sections, sections.count > 0 {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SourceCell
        let source = fetchedResultController.object(at: indexPath)
        cell.textLabel?.text = source.name
        let count = sourceCountWithSearchText(by: source)
        cell.detailTextLabel?.text = "\(count) article\(count == 1 ? "" : "s")"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let sections = fetchedResultController.sections, sections.count > 0 {
            return sections[section].name
        } else {
            return nil
        }
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return fetchedResultController.sectionIndexTitles
    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return fetchedResultController.section(forSectionIndexTitle: title, at: index)
    }
    
}

// MARK: - table view delegate
extension SourcesTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
