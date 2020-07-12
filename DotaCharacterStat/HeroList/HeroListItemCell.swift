//
//  HeroListItemCell.swift
//  DotaCharacterStat
//
//  Created by Muhammad Rifqi Fatchurrahman on 11/07/20.
//  Copyright © 2020 muhrifqii. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct HeroListItemCell: View {
    var hero: Hero
    
    var body: some View {
        VStack(alignment: .center) {
            KFImage.defaultView(hero.imageURL!)
                .scaledToFill()
            Text(hero.name).font(.system(size: 12)).lineLimit(1)
        }
    }
}

#if DEBUG 
struct HeroListItemCell_Previews: PreviewProvider {
    static var previews: some View {
        HeroListItemCell(hero: Hero.stub(json: jsonSample.data(using: .utf8)!))
    }
}
#endif
