//
//  HeroStatAPI.swift
//  DotaCharacterStat
//
//  Created by Muhammad Rifqi Fatchurrahman on 13/07/20.
//  Copyright © 2020 muhrifqii. All rights reserved.
//

import Moya

public enum HeroStatAPI {
    case getHero
}

extension HeroStatAPI: TargetType {
    public var baseURL: URL {
        return URL(string: DConst.BASE_URL + "/api")!
    }
    
    public var path: String {
        return "/herostats"
    }
    
    public var method: Method {
        return .get
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .getHero:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
}
