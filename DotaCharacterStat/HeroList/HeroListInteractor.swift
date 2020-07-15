//
//  MainInteractor.swift
//  Dota Character Stat
//
//  Created by Muhammad Rifqi Fatchurrahman on 10/07/20.
//  Copyright © 2020 muhrifqii. All rights reserved.
//

import Foundation
import Moya
import CoreData

class HeroListInteractor: HeroListInteractorTrait {
    let heroApi: MoyaProvider<HeroStatAPI>
    let persistentContainer: NSPersistentContainer
    private var request: Cancellable?
    
    init(persistentContainer: NSPersistentContainer) {
        heroApi = HeroStatAPI.defaultProvider
        self.persistentContainer = persistentContainer
    }
    
    func remoteFetch(_ completion: @escaping (Result<[Hero], RepositoryError>) -> Void) {
        if self.request != nil {
            self.request?.cancel()
            self.request = nil
        }
        self.request = heroApi.request(.getHero) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                do {
                    let d = try DNetworkDeps.shared.jsonDecoder.decode([Hero].self, from: response.data)
                    try self.store(d)
                    completion(Result.success(d))
                } catch let err {
                    completion(Result.failure(RepositoryError.server(err.localizedDescription)))
                }
            case let .failure(err):
                completion(Result.failure(RepositoryError.server(err.localizedDescription)))
            }
        }
    }
    
    func localFetch(_ completion: @escaping (Result<[Hero], RepositoryError>) -> Void) {
        
        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<PersistedHero>(entityName: "Hero")
        let sortDescriptor1 = NSSortDescriptor(key: Hero.CodingKeys.name.rawValue, ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor1]
        do {
            try managedObjectContext.fetch(fetchRequest).count
//            let heroes = try managedObjectContext.fetch(fetchRequest).map { $0.toCodableObject() }
//            completion(Result.success(heroes))
        } catch let error {
            NSLog("%@", error.localizedDescription)
        }
    }
    
    func filter(by role: String, completion: @escaping (Result<[Hero], RepositoryError>) -> Void) {
        
    }
    
    private func store(_ data: [Hero]) throws {
        let context = self.persistentContainer.viewContext
        // refresh all the stored data
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Hero")
        let request = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        try context.execute(request)
        
//        let insertRequest = NSBatchInsertRequest(entityName: "Hero", objects: <#T##[[String : Any]]#>)

        data.forEach { h in
            _ = h.toPersistedObject(context)
        }
        try context.save()
    }
}
