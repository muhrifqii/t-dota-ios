//
//  PreviewHeroTrait.swift
//  DotaCharacterStat
//
//  Created by Muhammad Rifqi Fatchurrahman on 16/07/20.
//  Copyright © 2020 muhrifqii. All rights reserved.
//

public protocol PreviewHeroViewTrait: BaseViewTrait {
    var presenter: PreviewHeroPresenterTrait { get }
    
    func onViewReloaded(hero: Hero, suggested: [Hero])
}

public protocol PreviewHeroInteractorTrait: BaseInteractorTrait {
    func loadSuggestion(_ hero: Hero, _ completion: @escaping (Result<[Hero], RepositoryError>) -> Void)
}

public protocol PreviewHeroPresenterTrait: BasePresenterTrait {
    var interactor: PreviewHeroInteractorTrait { get }
    var view: PreviewHeroViewTrait? { get }
    var wireframe: PreviewHeroWireframeTrait? { get }
    
    func loadData(for hero: Hero)
}

public protocol PreviewHeroWireframeTrait: BaseWireframeTrait {
}
