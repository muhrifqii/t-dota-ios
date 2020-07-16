//
//  PreviewHeroInteractor.swift
//  DotaCharacterStat
//
//  Created by Muhammad Rifqi Fatchurrahman on 16/07/20.
//  Copyright © 2020 muhrifqii. All rights reserved.
//

import Foundation
import CoreData

class PreviewHeroInteractor: PreviewHeroInteractorTrait {
    let persistentContainer: NSPersistentContainer
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }
    
    func loadSuggestion(_ hero: Hero, _ completion: @escaping (Result<[Hero], RepositoryError>) -> Void) {
        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<PersistedHero>()
        let entity = NSEntityDescription.entity(forEntityName: "Hero", in: managedObjectContext)
        fetchRequest.entity = entity
        // general rules 1 (same attribute)
        fetchRequest.predicate = NSPredicate(format: "primaryAttr == %@ && id != %d", hero.primaryAttr, hero.id)
        // apply rules
        switch hero.primaryAttributes {
        case .agi:
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "moveSpeed", ascending: false)]
        case .str:
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "attackMax", ascending: false)]
        case .int:
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "mana", ascending: false)]
        }
        do {
            // apply general rules 2 (same roles)
            let heroes = try managedObjectContext.fetch(fetchRequest).map { $0.toCodableObject() }
            var filteredHeroes: [Hero] = []
            for h in heroes {
                if !h.roles.filter({ hero.roles.contains($0) }).isEmpty {
                    filteredHeroes.append(h)
                }
                if filteredHeroes.count == 3 { break }
            }
            completion(Result.success(filteredHeroes))
        } catch let error {
            completion(Result.failure(RepositoryError.other(error.localizedDescription)))
            NSLog("%@", error.localizedDescription)
        }
    }
}
