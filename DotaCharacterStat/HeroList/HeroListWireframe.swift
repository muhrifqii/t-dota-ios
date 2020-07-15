//
//  HeroListWireframe.swift
//  DotaCharacterStat
//
//  Created by Muhammad Rifqi Fatchurrahman on 11/07/20.
//  Copyright © 2020 muhrifqii. All rights reserved.
//

import SwiftUI
import CoreData

class HeroListWireframe: HeroListWireframeTrait {
    var swiftui: HeroListView?
    
    /// manual injection
    static func initModule(persistentContainer: NSPersistentContainer) -> HeroListView {
        let wireframe = HeroListWireframe()
        let interactor = HeroListInteractor(persistentContainer: persistentContainer)
        let presenter = HeroListPresenter(interactor: interactor)
        let observer = HeroListObservedPresenter(presenter: presenter)
        
        presenter.view = observer
        presenter.wireframe = wireframe

        return HeroListView(observable: observer)
    }
    
    func navigatePreviewView() {
        
    }
}
