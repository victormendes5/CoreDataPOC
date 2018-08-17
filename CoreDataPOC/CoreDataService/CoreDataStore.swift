//
//  CoreDataStore.swift
//  CoreDataPOC
//
//  Created by João Mendes | Stone on 17/08/18.
//  Copyright © 2018 StoneCo. All rights reserved.
//

import UIKit
import CoreData

public class CoreDataStore {
    
    public static let shared = CoreDataStore()
    
    var persistentStoreCoordinator: NSPersistentStoreCoordinator? {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            return appDelegate.persistentContainer.persistentStoreCoordinator
        }
        return nil
    }
    
    var managedObjectModel: NSManagedObjectModel? {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            return appDelegate.persistentContainer.managedObjectModel
        }
        return nil
    }
    
    var managedObjectContext: NSManagedObjectContext? {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            return appDelegate.persistentContainer.viewContext
        }
        return nil
    }
    
}
