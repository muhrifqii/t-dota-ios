//
//  HeroListPresenter.swift
//  DotaCharacterStat
//
//  Created by Muhammad Rifqi Fatchurrahman on 11/07/20.
//  Copyright © 2020 muhrifqii. All rights reserved.
//

protocol HeroListPresenterTrait: BasePresenterTrait {
}

final class HeroListPresenter: HeroListPresenterTrait {
    private (set) var interactor: HeroListInteractor
    
    init(interactor: HeroListInteractor) {
        self.interactor = interactor
    }
}
