//
//  ViewController.swift
//  ConnectedScrolls
//
//  Created by Kyle LeNeau on 8/25/16.
//  Copyright © 2016 Kyle LeNeau. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        return 10
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventCell", for: indexPath) as! EventCollectionCell
        cell.contentView.backgroundColor = UIColor.red
        return cell
    }
}

extension EventsViewController: UITableViewDelegate {
    
}

extension EventsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventTableCell
        
        return cell
    }
}
