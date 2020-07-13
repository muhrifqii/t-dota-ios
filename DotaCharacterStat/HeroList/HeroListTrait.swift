//
//  HeroListTrait.swift
//  DotaCharacterStat
//
//  Created by Muhammad Rifqi Fatchurrahman on 13/07/20.
//  Copyright © 2020 muhrifqii. All rights reserved.
//

public protocol HeroListViewTrait: BaseViewTrait {
    var presenter: HeroListPresenterTrait { get }
    
    func onDataLoaded(_ data: [Hero])
    func onRoleLoaded(_ role: [String])
}

public protocol HeroListInteractorTrait: BaseInteractorTrait {
    func remoteFetch(_ completion: @escaping (Result<[Hero], RepositoryError>) -> Void)
    func localFetch(_ completion: @escaping (Result<[Hero], RepositoryError>) -> Void)
    func filter(by role: String, completion: @escaping (Result<[Hero], RepositoryError>) -> Void)
}

public protocol HeroListPresenterTrait: BasePresenterTrait {
    var interactor: HeroListInteractorTrait { get }
    var view: HeroListViewTrait? { get }
    var wireframe: HeroListWireframeTrait? { get }
    
    func loadData()
    func filter(by role: String)
}

public protocol HeroListWireframeTrait: BaseWireframeTrait {
}
