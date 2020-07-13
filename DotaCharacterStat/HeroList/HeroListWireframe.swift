//
//  HeroListWireframe.swift
//  DotaCharacterStat
//
//  Created by Muhammad Rifqi Fatchurrahman on 11/07/20.
//  Copyright © 2020 muhrifqii. All rights reserved.
//

import SwiftUI

class HeroListWireframe: HeroListWireframeTrait {
    /// manual injection
    static func initModule() -> HeroListView {
        let wireframe = HeroListWireframe()
        let interactor = HeroListInteractor()
        let presenter = HeroListPresenter(interactor: interactor)
        let observer = HeroListObservedPresenter(presenter: presenter)
        
        presenter.view = observer
        presenter.wireframe = wireframe

        return HeroListView(observable: observer)
    }
}
