//
//  Errors.swift
//  DotaCharacterStat
//
//  Created by Muhammad Rifqi Fatchurrahman on 13/07/20.
//  Copyright © 2020 muhrifqii. All rights reserved.
//

import Foundation

public enum RepositoryError: Error {
    case server(String), other(String)
}
