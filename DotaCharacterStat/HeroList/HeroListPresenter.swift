//
//  HeroListPresenter.swift
//  DotaCharacterStat
//
//  Created by Muhammad Rifqi Fatchurrahman on 11/07/20.
//  Copyright © 2020 muhrifqii. All rights reserved.
//

import Foundation

final class HeroListPresenter: HeroListPresenterTrait {
    
    private (set) var interactor: HeroListInteractorTrait
    weak var view: HeroListViewTrait?
    weak var wireframe: HeroListWireframeTrait?
    
    private var data: [Hero] = []
    
    init(interactor: HeroListInteractorTrait) {
        self.interactor = interactor
    }
    
    func loadData() {
        self.view?.showProgress()
        DispatchQueue.background(background: { [weak self] in
            guard let self = self else { return }

            // load local first
            self.interactor.localFetch { result in
                switch result {
                case let .success(list):
                    DispatchQueue.main.async {
                        self.view?.onDataLoaded(list)
                    }
                case let .failure(err):
                    self.errorDelegator(err)
                }
            }
            // then this
            self.interactor.remoteFetch { result in
                switch result {
                case let .success(list):
                    // process role
                    var set = Set<String>()
                    for hero in list {
                        let n = hero.roles.count
                        for i in 0..<n {
                            set.insert(hero.roles[i])
                        }
                    }
                    self.data = list
                    DispatchQueue.main.async {
                        self.view?.onRoleLoaded(Array(set))
                        self.view?.onDataLoaded(list)
                    }
                case let .failure(err):
                    self.errorDelegator(err)
                }
            }
        }, completion: { [weak self] in
            self?.view?.hideProgress()
        })
    }
    
    func filter(by role: String) {
        DispatchQueue.background(background: { [weak self] in
            guard let self = self else { return }
            
            let filtered = role == "All" ? self.data : self.data.filter { $0.roles.contains(role) }
            DispatchQueue.main.async {
                self.view?.onDataLoaded(filtered)
            }
        }, completion: {
        })
    }
    
    private func errorDelegator(_ err: RepositoryError) {
        let title: String
        let msg: String
        switch err {
        case let .server(str):
            title = "Can't Reach The Server"
            msg = str
        case let .other(str):
            title = "Error"
            msg = str
        }
        DispatchQueue.main.async {
            self.view?.showError(title, message: msg)
        }
    }
}
