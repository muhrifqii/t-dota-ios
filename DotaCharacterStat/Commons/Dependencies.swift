//
//  DConst.swift
//  Dota Character Stat
//
//  Created by Muhammad Rifqi Fatchurrahman on 10/07/20.
//  Copyright © 2020 muhrifqii. All rights reserved.
//

import Foundation

public struct DConst {
    static let BASE_URL = "https://api.opendota.com"
    static let managedUserInfoKey = CodingUserInfoKey.init(rawValue: "managed.context")
}

public class DNetworkDeps {
    public static let shared = DNetworkDeps()
        
    private (set) var jsonDecoder: JSONDecoder
    
    private init() {
        self.jsonDecoder = JSONDecoder()
    }
}

#if DEBUG
let jsonSample = """
{
  "id": 7,
  "name": "npc_dota_hero_earthshaker",
  "localized_name": "Earthshaker",
  "primary_attr": "str",
  "attack_type": "Melee",
  "roles": [
    "Support",
    "Initiator",
    "Disabler",
    "Nuker"
  ],
  "img": "/apps/dota2/images/heroes/earthshaker_full.png?",
  "icon": "/apps/dota2/images/heroes/earthshaker_icon.png",
  "base_health": 200,
  "base_health_regen": 1,
  "base_mana": 75,
  "base_mana_regen": 0,
  "base_armor": 2,
  "base_mr": 25,
  "base_attack_min": 27,
  "base_attack_max": 37,
  "base_str": 22,
  "base_agi": 12,
  "base_int": 16,
  "str_gain": 3.7,
  "agi_gain": 1.4,
  "int_gain": 1.8,
  "attack_range": 150,
  "projectile_speed": 0,
  "attack_rate": 1.7,
  "move_speed": 310,
}
"""
#endif
