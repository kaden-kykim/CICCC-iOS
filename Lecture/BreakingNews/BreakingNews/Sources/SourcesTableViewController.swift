//
//  SourcesTableViewController.swift
//  BreakingNews
//
//  Created by Derrick Park on 5/26/20.
//  Copyright © 2020 Derrick Park. All rights reserved.
//

import UIKit
import CoreData

class SourcesTableViewController: FetchedResultsTableViewController {
    private let cellId = "SourceCell"
    
    private lazy var fetchedResultsController: NSFetchedResultsController<ManagedSource> = {
        let request: NSFetchRequest<ManagedSource> = ManagedSource.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))]
        request.predicate = NSPredicate(format: "ANY articles.searchText CONTAINS[c] %@", searchText)
        
        let frc = NSFetchedResultsController<ManagedSource>(
            fetchRequest: request,
//            managedObjectContext: container.viewContext,
            managedObjectContext: (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext,
            sectionNameKeyPath: "firstLetter",
            cacheName: nil
        )
        // It's going to permanently cache the results (store on disk in some internal format)
        // Be sure that any cacheName you use is always associated with exactly the same request.
        // You'll have to invalidate the cache if you change anything about the request. (There's an API for it)
        // It's okay to specify nil for the cacheName (no cacheing of fetch results in that case.)
        
        frc.delegate = self
        return frc
    }()
    
    var container: NSPersistentContainer!
    var searchText: String! { didSet { updateUI() } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sources for \(searchText!)"
        tableView.register(SourceCell.self, forCellReuseIdentifier: cellId)
    }
    
    private func updateUI() {
        try? fetchedResultsController.performFetch()
        tableView.reloadData()
    }
    
    private func sourceCountWithSearchText(by source: ManagedSource) -> Int {
        let request: NSFetchRequest<ManagedArticle> = ManagedArticle.fetchRequest()
        request.predicate = NSPredicate(format: "searchText CONTAINS[c] %@ AND source == %@", searchText, source)
        return (try? source.managedObjectContext!.count(for: request)) ?? 0
    }
}

extension SourcesTableViewController {
    // MARK: - table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections, sections.count > 0 {
            return sections[section].numberOfObjects
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SourceCell
        let source = fetchedResultsController.object(at: indexPath)
        cell.textLabel?.text = source.name
        let count = sourceCountWithSearchText(by: source)
        cell.detailTextLabel?.text = "\(count) article\((count == 1) ? "" : "s")"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let sections = fetchedResultsController.sections, sections.count > 0 {
            return sections[section].name
        } else {
            return nil
        }
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return fetchedResultsController.sectionIndexTitles
    }
    
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return fetchedResultsController.section(forSectionIndexTitle: title, at: index)
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
