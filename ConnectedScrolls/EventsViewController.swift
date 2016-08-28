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
        let eventRequest: NSFetchRequest<Event> = Event.fetchRequest()
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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let indexPath = IndexPath(item: 360, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension EventsViewController: UICollectionViewDelegate, UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        print(offset)
    }
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
        cell.label.text = event.name
        cell.label.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI / -2));
        
        return cell
    }
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
