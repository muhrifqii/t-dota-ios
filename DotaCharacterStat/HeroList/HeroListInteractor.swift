//
//  MainInteractor.swift
//  Dota Character Stat
//
//  Created by Muhammad Rifqi Fatchurrahman on 10/07/20.
//  Copyright © 2020 muhrifqii. All rights reserved.
//

import Foundation
import Moya

class HeroListInteractor: HeroListInteractorTrait {
    let heroApi: MoyaProvider<HeroStatAPI>
    private var request: Cancellable?
    
    init() {
        heroApi = HeroStatAPI.defaultProvider
    }
    
    func remoteFetch(_ completion: @escaping (Result<[Hero], RepositoryError>) -> Void) {
        if self.request != nil {
            self.request?.cancel()
            self.request = nil
        }
        self.request = heroApi.request(.getHero) { result in
            switch result {
            case let .success(response):
                do {
                    let d = try DNetworkDeps.shared.jsonDecoder.decode([Hero].self, from: response.data)
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
        
    }
    
    func filter(by role: String, completion: @escaping (Result<[Hero], RepositoryError>) -> Void) {
        
    }
}
