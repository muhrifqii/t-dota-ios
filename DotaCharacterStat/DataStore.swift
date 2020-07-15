//
//  DataStore.swift
//  DotaCharacterStat
//
//  Created by Muhammad Rifqi Fatchurrahman on 14/07/20.
//  Copyright © 2020 muhrifqii. All rights reserved.
//

import UIKit
import CoreData

public final class DataStore: NSObject {
    public private (set) var persistentContainer: NSPersistentContainer!
    
    public lazy var applicationDocumentsDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    public lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: "HeroStat", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
//    public lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
//        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
//        // Create the coordinator and store
//        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
//        var failureReason = "There was an error creating or loading the application's saved data."
//        do {
//            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
//        } catch {
//            // Report any error we got.
//            var dict = [String: Any]()
//            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
//            dict[NSLocalizedFailureReasonErrorKey] = failureReason
//
//            dict[NSUnderlyingErrorKey] = error as NSError
//            let wrappedError = NSError(domain: "DotaCharacterStat", code: 123123, userInfo: dict)
//            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
//            abort()
//        }
//
//        return coordinator
//      }()
    
    public init(completion: @escaping () -> Void) {
        self.persistentContainer = NSPersistentContainer(name: "HeroStat")
        persistentContainer.loadPersistentStores() { (description, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
            completion()
        }
        super.init()
    }
    
    private override init() {
        fatalError()
    }
    
    public func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
