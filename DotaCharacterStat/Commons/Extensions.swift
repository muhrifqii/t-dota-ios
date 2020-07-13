//
//  Extensions.swift
//  DotaCharacterStat
//
//  Created by Muhammad Rifqi Fatchurrahman on 11/07/20.
//  Copyright © 2020 muhrifqii. All rights reserved.
//

import Foundation
import KingfisherSwiftUI
import SwiftUI
import Moya

public extension KFImage {
    static func defaultView(_ url: URL) -> KFImage {
        return KFImage(url, options: [.progressiveJPEG(.default)])
            .placeholder { Image(systemName: "plus").imageScale(.large) }
            .resizable(capInsets: .init(top: 0, leading: 0, bottom: 0, trailing: 0),
                       resizingMode: .stretch)
    }
}

extension DispatchQueue {
    static var repositories: DispatchQueue { DispatchQueue.global(qos: .background) }
    
    static func background(delay: Double = 0.0, background: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }
}

extension TargetType {
    static var defaultProvider: MoyaProvider<Self> {
        var plugin: [PluginType] = []
        #if DEBUG
        plugin = [NetworkLoggerPlugin(configuration: .init())]
        #endif
        return .init(callbackQueue: DispatchQueue.repositories, plugins: plugin)
    }
}
