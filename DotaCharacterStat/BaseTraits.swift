//
//  BaseTraits.swift
//  DotaCharacterStat
//
//  Created by Muhammad Rifqi Fatchurrahman on 11/07/20.
//  Copyright © 2020 muhrifqii. All rights reserved.
//

public protocol BaseViewTrait: AnyObject {    
    func showError(_ title: String, message: String?)
    func showProgress()
    func hideProgress()
}

public protocol BasePresenterTrait: AnyObject {
}

public protocol BaseInteractorTrait: AnyObject {
}

public protocol BaseWireframeTrait: AnyObject {
}
