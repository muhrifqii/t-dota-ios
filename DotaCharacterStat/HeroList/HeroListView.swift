//
//  ContentView.swift
//  Dota Character Stat
//
//  Created by Muhammad Rifqi Fatchurrahman on 10/07/20.
//  Copyright © 2020 muhrifqii. All rights reserved.
//

import SwiftUI
import QGrid

final class HeroListObservedPresenter: ObservableObject, HeroListViewTrait {
    
    let presenter: HeroListPresenterTrait
    
    @Published var selectedRole = "All"
    @Published var roles: [String] = []
    @Published var heros: [Hero] = []
    @Published var alert: AlertBinding?
    
    init(presenter: HeroListPresenterTrait) {
        self.presenter = presenter
    }
    
    func onDataLoaded(_ data: [Hero]) {
        self.heros = data
    }
    
    func onRoleLoaded(_ role: [String]) {
        self.roles = role
    }
    
    func showError(_ title: String, message: String?) {
        alert = .init(title, message: message, positive: nil)
    }
    
    func showProgress() {
    }
    
    func hideProgress() {
    }
    
    func dummyData() -> [Hero] {
        return (0..<120)
            .map { x in Hero.stub(json: jsonSample.data(using: .utf8)!) }
    }
}

struct HeroListView: View {
    @ObservedObject var observable: HeroListObservedPresenter
    @State var progress: Float = 0.8

    var header: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(self.observable.roles, id: \.self) { item in
                    Button(action: self.onRoleTapped(item)) {
                        Text(item).padding(5)
                            .foregroundColor((item == self.observable.selectedRole) ? .blue : .black)
                            .background(RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color.gray.opacity(0.3)))
                    }
                }
            }
            .frame(width: nil, height: 30, alignment: .leading)
            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
        }
    }
    
    var body: some View {
        TitleNavigationView(title: $observable.selectedRole) {
            GeometryReader { (gm: GeometryProxy) in
                VStack {
                    self.header
                    if !self.observable.heros.isEmpty {
                        QGrid(self.observable.heros, columns: 2, columnsInLandscape: 4,
                              vSpacing: 10, hSpacing: 0,
                              vPadding: 0, hPadding: 0,
                              isScrollable: true, showScrollIndicators: true) { item in
                                VStack {
                                    NavigationLink(destination: PreviewHeroView(observable: .init(hero: item))) {
                                        HeroListItemCell(hero: item)
                                    }.buttonStyle(PlainButtonStyle())
                                }
                        }
                    }
                }.frame(width: gm.size.width, height: gm.size.height, alignment: .topLeading)
            }
        }
        .onAppear {
            self.observable.presenter.loadData()
        }
        .alert(item: self.$observable.alert) { (item: AlertBinding) in
            Alert(title: Text(item.title),
                  message: item.message != nil ? Text(item.message!) : nil,
                  dismissButton: .default(Text(item.positive ?? "OK"), action: { self.observable.alert = nil }))
        }
    }
    
    func onRoleTapped(_ role: String) -> () -> Void {
        return {
            if self.observable.selectedRole == role {
                self.observable.selectedRole = "All"
            } else {
                self.observable.selectedRole = role
            }
            self.observable.presenter.filter(by: self.observable.selectedRole)
        }
    }
}

#if DEBUG
struct HeroListView_Preview: PreviewProvider {
    static var previews: some View {
        let v = HeroListWireframe.initModule()
        v.observable.roles = ["Pusher", "Carry", "Support"]
        v.observable.heros = v.observable.dummyData()
        return v.previewDevice("iPhone 8")
    }
}
#endif
