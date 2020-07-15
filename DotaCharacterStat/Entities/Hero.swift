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
    var primaryAttributes: HeroAttributeType { HeroAttributeType(rawValue: primaryAttr)! }
    
    static func stub(json: Data) -> Hero {
        let decodable = try! JSONDecoder().decode(Hero.self, from: json)
        return decodable
    }
    
    func toPersistedObject(_ context: NSManagedObjectContext) -> PersistedHero {
        let o = PersistedHero(context: context)
        
        o.setValue(id, forKey: "id")
        o.setValue(name, forKey: "name")
        o.setValue(primaryAttr, forKey: "primaryAttr")
        o.setValue(attackType, forKey: "attackType")
        o.setValue(roles, forKey: "roles")
        o.setValue(imgUrl, forKey: "imgUrl")
        o.setValue(iconUrl, forKey: "iconUrl")
        o.setValue(health, forKey: "health")
        o.setValue(mana, forKey: "mana")
        o.setValue(armor, forKey: "armor")
        o.setValue(attackMin, forKey: "attackMin")
        o.setValue(attackMax, forKey: "attackMax")
        o.setValue(moveSpeed, forKey: "moveSpeed")
        o.setValue(str, forKey: "str")
        o.setValue(agi, forKey: "agi")
        o.setValue(int, forKey: "int")
        return o
    }
}

public enum HeroAttributeType: String {
    case str, int, agi
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
    
    func toCodableObject() -> Hero {
        Hero(id: id, name: name, primaryAttr: primaryAttr,
             attackType: attackType, roles: roles,
             imgUrl: imgUrl, iconUrl: iconUrl,
             health: health, mana: mana,
             armor: armor, attackMin: attackMin, attackMax: attackMax,
             moveSpeed: moveSpeed, str: str, agi: agi, int: int)
    }
}

