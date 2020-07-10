//
//  PreviewHeroView.swift
//  DotaCharacterStat
//
//  Created by Muhammad Rifqi Fatchurrahman on 11/07/20.
//  Copyright © 2020 muhrifqii. All rights reserved.
//

import SwiftUI

struct PreviewHeroView: View {
    var hero: Hero
    
    var body: some View {
        List {
            Text("attack: \(hero.attackMin) - \(hero.attackMax)").lineLimit(1)
        }.navigationBarTitle(Text("Ready"), displayMode: .inline)
    }
}

#if DEBUG
struct PreviewHeroView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewHeroView(hero: Hero.stub(json: jsonSample.data(using: .utf8)!))
    }
}
#endif
