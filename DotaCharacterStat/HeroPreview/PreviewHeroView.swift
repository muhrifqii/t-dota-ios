//
//  PreviewHeroView.swift
//  DotaCharacterStat
//
//  Created by Muhammad Rifqi Fatchurrahman on 11/07/20.
//  Copyright © 2020 muhrifqii. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

public protocol PreviewHeroViewTrait: BaseViewTrait {
}

class PreviewHeroObservedPresenter: ObservableObject, PreviewHeroViewTrait {
    @Published var hero: Hero
    @Published var recommendedHero: [Hero] = []
    
    init(hero: Hero) {
        self.hero = hero
        self.recommendedHero = (0..<3).map { _ in hero }
    }
    
    func showError(_ title: String, message: String?) {
        
    }
    
    func showProgress() {
        
    }
    
    func hideProgress() {
        
    }
}

struct PreviewHeroView: View {
    @ObservedObject var observable: PreviewHeroObservedPresenter
    
    func toggleFontWeight(_ type: HeroAttributeType) -> Font.Weight {
        return .regular
    }
    
    var body: some View {
        GeometryReader { (g: GeometryProxy) in
            List {
                Section(header: KFImage.defaultView(self.observable.hero.imageURL!).scaledToFit()) {
                    HStack(alignment: .center) {
                        Text(String(format: "Types: %@", self.observable.hero.attackType))
                            .lineLimit(1)
                            .frame(width: g.size.width / 2 - 20, height: nil)
                        Text(String(format: "Attributes: %@", self.observable.hero.primaryAttr))
                            .lineLimit(1)
                            .frame(width: g.size.width / 2 - 20, height: nil)
                    }
                    HStack(alignment: .center) {
                        Text(String(format: "Health Pool: %d", self.observable.hero.health))
                            .lineLimit(1)
                            .frame(width: g.size.width / 2 - 20, height: nil)
                        Text(String(format: "Mana Pool: %d", self.observable.hero.mana))
                            .lineLimit(1)
                            .frame(width: g.size.width / 2 - 20, height: nil)
                    }
                    HStack(alignment: .center, spacing: 10) {
                        VStack(alignment: .center, spacing: 10) {
                            Text("Attack: \(self.observable.hero.attackMin) - \(self.observable.hero.attackMax)").lineLimit(1)
                            Text(String(format: "Armor: %.1lf", self.observable.hero.armor)).lineLimit(1)
                            Text(String(format: "Move Speed: %d", self.observable.hero.moveSpeed)).lineLimit(1)
                        }.frame(width: g.size.width / 2 - 20, height: nil)
                        VStack(alignment: .center, spacing: 10) {
                            Text("Str: \(self.observable.hero.str)")
                                .fontWeight(.regular)
                                .lineLimit(1)
                            Text(String(format: "Agi: %d", self.observable.hero.agi))
                                .fontWeight(.regular)
                                .lineLimit(1)
                            Text(String(format: "Int: %d", self.observable.hero.int))
                                .fontWeight(.regular)
                                .lineLimit(1)
                        }.frame(width: g.size.width / 2 - 20, height: nil)
                    }
                    VStack(alignment: .center, spacing: 0) {
                        Text("Roles:")
                            .frame(width: g.size.width - 30, height: nil)
                            .lineLimit(1)
                        HStack(alignment: .center, spacing: 10) {
                            Text(self.observable.hero.roles.joined(separator: ", ")).fontWeight(.regular)
                        }
                    }
                }
                Section(header: Text("Similar Hero")) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(self.observable.recommendedHero, id: \.id) { item in
                                KFImage.defaultView(item.imageURL!).frame(width: nil, height: 132, alignment: .center)
                            }
                        }
                    }
                }
            }
        }.navigationBarTitle(Text(self.observable.hero.name), displayMode: .large)
    }
}

#if DEBUG
struct PreviewHeroView_Previews: PreviewProvider {
    static var previews: some View {
        let hero = Hero.stub(json: jsonSample.data(using: .utf8)!)
        return PreviewHeroView(observable: .init(hero: hero))
    }
}
#endif
