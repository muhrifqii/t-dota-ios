//
//  BaseTraits.swift
//  DotaCharacterStat
//
//  Created by Muhammad Rifqi Fatchurrahman on 11/07/20.
//  Copyright © 2020 muhrifqii. All rights reserved.
//

public protocol BaseViewTrait {
    func showError(_ title: String, message: String?)
    func showProgress()
    func hideProgress()
}

public protocol BasePresenterTrait {
    associatedtype Interactor : BaseInteractorTrait
    var interactor: Interactor { get }
}

public protocol BaseInteractorTrait {
}

public protocol BaseWireframeTrait {
}
