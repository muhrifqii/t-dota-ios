//
//  PreviewHeroView.swift
//  DotaCharacterStat
//
//  Created by Muhammad Rifqi Fatchurrahman on 11/07/20.
//  Copyright © 2020 muhrifqii. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

class PreviewHeroObservedPresenter: ObservableObject, PreviewHeroViewTrait {
    let presenter: PreviewHeroPresenterTrait
    
    @Published var hero: Hero?
    @Published var recommendedHero: [Hero] = []
    @Published var alert: AlertBinding?
    @Published var loading = true
    
    init(presenter: PreviewHeroPresenterTrait) {
        self.presenter = presenter
    }
    
    func onViewReloaded(hero: Hero, suggested: [Hero]) {
        self.hero = hero
        self.recommendedHero = suggested
    }
    
    func showError(_ title: String, message: String?) {
        alert = .init(title, message: message, positive: nil)
    }
    
    func showProgress() {
        loading = true
    }
    
    func hideProgress() {
        loading = false
    }
    
    internal func loadSuggestion() {
        guard let hero = self.hero else { return }
        self.presenter.loadData(for: hero)
    }
    
    internal func reloadHero(_ hero: Hero) {
        self.hero = hero
        self.loadSuggestion()
    }
}

struct PreviewHeroView: View {
    @ObservedObject var observable: PreviewHeroObservedPresenter
    
    func toggleFontWeight(_ type: HeroAttributeType) -> Font.Weight {
        return .regular
    }
    
    var similarHero: some View {
        Section(header: Text("Similar Hero")) {
            ScrollView(.horizontal, showsIndicators: false) {
                if !self.observable.loading {
                    HStack {
                        ForEach(self.observable.recommendedHero, id: \.id) { (item: Hero) in
                            KFImage.defaultView(item.imageURL!).frame(width: nil, height: 132, alignment: .center)
                                .onTapGesture { self.observable.reloadHero(item) }
                        }
                    }
                } else {
                    Text("Loading...").frame(width: nil, height: 132, alignment: .center)
                }
            }
        }
    }
    
    var inner: some View {
        GeometryReader { (g: GeometryProxy) in
            List {
                Section(header: KFImage.defaultView(self.observable.hero!.imageURL!).scaledToFit()) {
                    HStack(alignment: .center) {
                        Text(String(format: "Types: %@", self.observable.hero!.attackType))
                            .lineLimit(1)
                            .frame(width: g.size.width / 2 - 20, height: nil)
                        Text(String(format: "Attributes: %@", self.observable.hero!.primaryAttr))
                            .lineLimit(1)
                            .frame(width: g.size.width / 2 - 20, height: nil)
                    }
                    HStack(alignment: .center) {
                        Text(String(format: "Health Pool: %d", self.observable.hero!.health))
                            .lineLimit(1)
                            .frame(width: g.size.width / 2 - 20, height: nil)
                        Text(String(format: "Mana Pool: %d", self.observable.hero!.mana))
                            .lineLimit(1)
                            .frame(width: g.size.width / 2 - 20, height: nil)
                    }
                    HStack(alignment: .center, spacing: 10) {
                        VStack(alignment: .center, spacing: 10) {
                            Text("Attack: \(self.observable.hero!.attackMin) - \(self.observable.hero!.attackMax)").lineLimit(1)
                            Text(String(format: "Armor: %.1lf", self.observable.hero!.armor)).lineLimit(1)
                            Text(String(format: "Move Speed: %d", self.observable.hero!.moveSpeed)).lineLimit(1)
                        }.frame(width: g.size.width / 2 - 20, height: nil)
                        VStack(alignment: .center, spacing: 10) {
                            Text("Str: \(self.observable.hero!.str)")
                                .fontWeight(.regular)
                                .lineLimit(1)
                            Text(String(format: "Agi: %d", self.observable.hero!.agi))
                                .fontWeight(.regular)
                                .lineLimit(1)
                            Text(String(format: "Int: %d", self.observable.hero!.int))
                                .fontWeight(.regular)
                                .lineLimit(1)
                        }.frame(width: g.size.width / 2 - 20, height: nil)
                    }
                    VStack(alignment: .center, spacing: 0) {
                        Text("Roles:")
                            .frame(width: g.size.width - 30, height: nil)
                            .lineLimit(1)
                        HStack(alignment: .center, spacing: 10) {
                            Text(self.observable.hero!.roles.joined(separator: ", ")).fontWeight(.regular)
                        }
                    }
                }
                self.similarHero
            }
            .introspectTableView { t in
                t.separatorInset = .init(top: 0, left: 0, bottom: 0, right: 0)
            }
        }.navigationBarTitle(Text(self.observable.hero!.name), displayMode: .large)
    }
    
    var body: some View {
        VStack {
            if self.observable.hero != nil { inner } else { Text("Loading...") }
        }.onAppear {
            self.observable.loadSuggestion()
        }.alert(item: self.$observable.alert) { (item: AlertBinding) in
            Alert(title: Text(item.title),
                  message: item.message != nil ? Text(item.message!) : nil,
                  dismissButton: .default(Text(item.positive ?? "OK"), action: { self.observable.alert = nil }))
        }
    }
}

#if DEBUG
struct PreviewHeroView_Previews: PreviewProvider {
    static var previews: some View {
        let scene = SceneDelegate.instance()
        let hero = Hero.stub(json: jsonSample.data(using: .utf8)!)
        return PreviewHeroWireframe.initModule(persistentContainer: scene.dataStore!.persistentContainer, hero: hero)
    }
}
#endif
