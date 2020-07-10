//
//  MainInteractor.swift
//  Dota Character Stat
//
//  Created by Muhammad Rifqi Fatchurrahman on 10/07/20.
//  Copyright © 2020 muhrifqii. All rights reserved.
//

import Foundation

public protocol HeroListInteractorTrait: BaseInteractorTrait {
    func remoteFetch(_ callback: @escaping ([Hero]) -> Void)
    func localFetch()
}

class HeroListInteractor: HeroListInteractorTrait {
    
    /// Load all at once (no pagination on api)
    func remoteFetch(_ callback: @escaping ([Hero]) -> Void) {
        guard let url = URL(string: "\(DConst.BASE_URL)/herostats") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            if let res = try? JSONDecoder().decode([Hero].self, from: data) {
                callback(res)
            }
         }.resume()
    }
    
    func localFetch() {
    }
}
