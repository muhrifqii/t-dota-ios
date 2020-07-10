//
//  ContentView.swift
//  Dota Character Stat
//
//  Created by Muhammad Rifqi Fatchurrahman on 10/07/20.
//  Copyright © 2020 muhrifqii. All rights reserved.
//

import SwiftUI
import QGrid

public protocol HeroListViewTrait: BaseViewTrait {
}

struct TitleNavigationView<Content>: View where Content: View {
    @Binding var title: String
    let content: () -> Content
    
    init(title: Binding<String>, content: @escaping () -> Content) {
        self._title = title
        self.content = content
    }
    
    var body: some View {
        NavigationView {
            content()
                .navigationBarTitle(Text(title), displayMode: .inline)
                .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct HeroListSView: View {
    @State private var title: String = "All"

    var body: some View {
        TitleNavigationView(title: $title) {
            QGrid(self.dummyData(), columns: 2, columnsInLandscape: 4,
                  vSpacing: 10, hSpacing: 0,
                  vPadding: 0, hPadding: 0,
                  isScrollable: true, showScrollIndicators: true) { item in
                    VStack {
                        NavigationLink(destination: PreviewHeroView(hero: item)) {
                            HeroListItemCell(hero: item)
                        }.buttonStyle(PlainButtonStyle())
                    }
            }
        }
        .onAppear {
        }
    }
    
    func dummyData() -> [Hero] {
        return (0..<120)
            .map { x in Hero.stub(json: jsonSample.data(using: .utf8)!) }
    }
}

extension HeroListSView: HeroListViewTrait {
    func showError(_ title: String, message: String?) {
    }
    
    func showProgress() {
    }
    
    func hideProgress() {
    }
}

#if DEBUG
struct HeroListSView_Preview: PreviewProvider {
    static var previews: some View {
        HeroListSView().previewDevice("iPhone 8")
    }
}
#endif
