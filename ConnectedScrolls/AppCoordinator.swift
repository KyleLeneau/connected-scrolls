//
//  AppCoordinator.swift
//  ConnectedScrolls
//
//  Created by Kyle LeNeau on 8/25/16.
//  Copyright © 2016 Kyle LeNeau. All rights reserved.
//

import UIKit
import CoreData

final class AppCoordinator: Coordinator {
    
    let window: UIWindow
    let launchOptions: [UIApplicationLaunchOptionsKey: Any]?
    
    var navigationController: UINavigationController?
    
    init(window: UIWindow, launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        self.window = window
        self.launchOptions = launchOptions
    }
    
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let navVC = storyboard.instantiateInitialViewController() as! UINavigationController
        self.navigationController = navVC
        
        window.rootViewController = navVC
        
        seedData()
    }
    
    func seedData() {
        for x in 0...360 {
            let event = NSEntityDescription.insertNewObject(forEntityName: "Event", into: persistentContainer.viewContext) as! Event
            event.name = "Event \(x)"
            event.value = Float(x)
            event.date = NSDate()
        }
        
        saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "ConnectedScrolls")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
