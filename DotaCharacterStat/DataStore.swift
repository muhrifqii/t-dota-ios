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
