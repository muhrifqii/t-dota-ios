//
//  Hero.swift
//  DotaCharacterStat
//
//  Created by Muhammad Rifqi Fatchurrahman on 11/07/20.
//  Copyright © 2020 muhrifqii. All rights reserved.
//

import Foundation
import CoreData

public struct Hero: Decodable, Identifiable {
    enum CodingKeys: String, CodingKey {
        case id
        case name = "localized_name"
        case primaryAttr = "primary_attr"
        case attackType = "attack_type"
        case roles
        case imgUrl = "img"
        case iconUrl = "icon"
        case health = "base_health"
        case mana = "base_mana"
        case armor = "base_armor"
        case attackMin = "base_attack_min"
        case attackMax = "base_attack_max"
        case moveSpeed = "move_speed"
        case str = "base_str"
        case agi = "base_agi"
        case int = "base_int"
    }
    
    public var id: Int
    var name: String
    var primaryAttr: String
    var attackType: String
    var roles: [String]
    
    var imgUrl: String
    var iconUrl: String
    
    var health: Int
    var mana: Int
    
    var armor: Double
    var attackMin: Int
    var attackMax: Int
    var moveSpeed: Int
    
    var str: Int
    var agi: Int
    var int: Int
    
    var imageURL: URL? { URL(string: DConst.BASE_URL + imgUrl) }
    var iconURL: URL? { URL(string: DConst.BASE_URL + iconUrl) }
    
    static func stub(json: Data) -> Hero {
        let decodable = try! JSONDecoder().decode(Hero.self, from: json)
        return decodable
    }
}

public class PersistedHero: NSManagedObject {
    @NSManaged var id: Int
    @NSManaged var name: String
    @NSManaged var primaryAttr: String
    @NSManaged var attackType: String
    @NSManaged var roles: [String]
    
    @NSManaged var imgUrl: String
    @NSManaged var iconUrl: String
    
    @NSManaged var health: Int
    @NSManaged var mana: Int
    
    @NSManaged var armor: Double
    @NSManaged var attackMin: Int
    @NSManaged var attackMax: Int
    @NSManaged var moveSpeed: Int
    
    @NSManaged var str: Int
    @NSManaged var agi: Int
    @NSManaged var int: Int
}

