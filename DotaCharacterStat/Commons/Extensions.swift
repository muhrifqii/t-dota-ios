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

public extension KFImage {
    static func defaultView(_ url: URL) -> KFImage {
        return KFImage(url, options: [.progressiveJPEG(.default)])
            .placeholder { Image(systemName: "plus").imageScale(.large) }
            .resizable(capInsets: .init(top: 0, leading: 0, bottom: 0, trailing: 0),
                       resizingMode: .stretch)
    }
}
