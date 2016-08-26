//
//  ViewController.swift
//  ConnectedScrolls
//
//  Created by Kyle LeNeau on 8/25/16.
//  Copyright © 2016 Kyle LeNeau. All rights reserved.
//

import UIKit
import CoreData

class EventsViewController: UIViewController {

    var managedObjectContext: NSManagedObjectContext!
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var tableView: UITableView!
    
    lazy var fetchedResultsController: NSFetchedResultsController<Event> = {
        let eventRequest = Event.fetchRequest() as NSFetchRequest<Event>
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        eventRequest.sortDescriptors = [sortDescriptor]
        
        let frc = NSFetchedResultsController(
            fetchRequest: eventRequest,
            managedObjectContext: self.managedObjectContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        frc.delegate = self
        
        return frc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("An error occurred")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension EventsViewController: UICollectionViewDelegate {
    
}

extension EventsViewController: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let firstSection = fetchedResultsController.sections?.first {
            return firstSection.numberOfObjects
        }
        
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCell", for: indexPath) as! EventCollectionCell
        let event = fetchedResultsController.object(at: indexPath)
        
        cell.contentView.backgroundColor = UIColor.red
        cell.label.text = "\(event.value)"
        
        return cell
    }
}

extension EventsViewController: UITableViewDelegate {
    
}

extension EventsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let firstSection = fetchedResultsController.sections?.first {
            return firstSection.numberOfObjects
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventTableCell
        let event = fetchedResultsController.object(at: indexPath)
        
        cell.textLabel?.text = event.name
        
        return cell
    }
}

extension EventsViewController: NSFetchedResultsControllerDelegate {
    
    
}
