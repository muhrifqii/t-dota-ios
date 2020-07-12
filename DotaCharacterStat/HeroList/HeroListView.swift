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

class HeroListObservedPresenter: ObservableObject, HeroListViewTrait {
    @State var navigationTitle = "All"
    @Published var categories: [String] = ["KKK", "aafaf", "223123"]
    
    init() {
    }
    
    func showError(_ title: String, message: String?) {
        
    }
    
    func showProgress() {
        
    }
    
    func hideProgress() {
        
    }
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

struct AlertBinding: Identifiable {
    var id: Int
    var title: String
    var message: String?
    var positive: String?
    var negative: String?
    
    var positiveAction: (() -> Void)?
    var negativeAction: (() -> Void)?
    
    init(_ title: String, message: String?, positive: String?) {
        self.id = title.hashValue
        self.title = title
        self.message = message
        self.positive = positive
    }
}

struct HeroListSView: View {
    @ObservedObject var observable: HeroListObservedPresenter
    @State private var alert: AlertBinding?

    var body: some View {
        TitleNavigationView(title: observable.$navigationTitle) {
            VStack(alignment: .leading, spacing: 0) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(self.observable.categories, id: \.self) { item in
                            Button(action: self.onRoleTapped(item)) {
                                Text(item).padding(5)
                                    .foregroundColor(.black)
                                    .background(RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color.gray))
                            }
                        }
                    }
                }
                .padding(5)
                QGrid(self.dummyData(), columns: 2, columnsInLandscape: 4,
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
        }
        .onAppear {
        }
        .alert(item: self.$alert) { (item: AlertBinding) in
            Alert(title: Text(item.title),
                  message: item.message != nil ? Text(item.message!) : nil,
                  dismissButton: .default(Text(item.positive ?? "OK"), action: { self.alert = nil }))
        }
    }
    
    func onRoleTapped(_ role: String) -> () -> Void {
        return {
            self.alert = AlertBinding(role, message: nil, positive: nil)
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
        HeroListSView(observable: .init()).previewDevice("iPhone 8")
    }
}
#endif
