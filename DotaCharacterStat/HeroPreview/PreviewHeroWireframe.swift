//
//  PreviewHeroWireframe.swift
//  DotaCharacterStat
//
//  Created by Muhammad Rifqi Fatchurrahman on 12/07/20.
//  Copyright © 2020 muhrifqii. All rights reserved.
//

import Foundation
import CoreData

class PreviewHeroWireframe: PreviewHeroWireframeTrait {
    
    /// manual injection
    static func initModule(persistentContainer: NSPersistentContainer, hero: Hero) -> PreviewHeroView {
        let wireframe = PreviewHeroWireframe()
        let interactor = PreviewHeroInteractor(persistentContainer: persistentContainer)
        let presenter = PreviewHeroPresenter(interactor: interactor)
        let observer = PreviewHeroObservedPresenter(presenter: presenter)
        
        observer.hero = hero
        presenter.view = observer
        presenter.wireframe = wireframe
        
        return PreviewHeroView(observable: observer)
    }
}
