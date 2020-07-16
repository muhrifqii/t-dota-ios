//
//  PreviewHeroPresenter.swift
//  DotaCharacterStat
//
//  Created by Muhammad Rifqi Fatchurrahman on 16/07/20.
//  Copyright © 2020 muhrifqii. All rights reserved.
//

import Foundation

class PreviewHeroPresenter: PreviewHeroPresenterTrait {
    private (set) var interactor: PreviewHeroInteractorTrait
    var view: PreviewHeroViewTrait?
    var wireframe: PreviewHeroWireframeTrait?
    
    init(interactor: PreviewHeroInteractorTrait) {
        self.interactor = interactor
    }
    
    func loadData(for hero: Hero) {
        self.view?.showProgress()
        DispatchQueue.background(background: { [weak self] in
            guard let self = self else { return }

            self.interactor.loadSuggestion(hero) { result in
                switch result {
                case let .success(list):
                    DispatchQueue.main.async {
                        self.view?.onViewReloaded(hero: hero, suggested: list)
                    }
                case let .failure(err):
                    DispatchQueue.main.async {
                        self.view?.showError("Error", message: err.localizedDescription)
                    }
                }
            }
        }, completion: { [weak self] in
            self?.view?.hideProgress()
        })
    }
    
}
