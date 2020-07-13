//
//  CommonView.swift
//  DotaCharacterStat
//
//  Created by Muhammad Rifqi Fatchurrahman on 13/07/20.
//  Copyright © 2020 muhrifqii. All rights reserved.
//

import Foundation
import SwiftUI
import Introspect

/// Just ordinary NavigationView Builder with navigation title binding
public struct TitleNavigationView<Content>: View where Content: View {
    @Binding public private (set) var title: String
    private let content: () -> Content
    
    public init(title: Binding<String>, content: @escaping () -> Content) {
        self._title = title
        self.content = content
    }
    
    public var body: some View {
        NavigationView {
            content()
                .navigationBarTitle(Text(title), displayMode: .inline)
                .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

/// UIKit on SwiftUI integrator for pull to refresh controll
private struct PullToRefresh: UIViewRepresentable {
    
    @Binding var isShowing: Bool
    let onRefresh: () -> Void
    
    public init(isShowing: Binding<Bool>, onRefresh: @escaping () -> Void) {
        _isShowing = isShowing
        self.onRefresh = onRefresh
    }
    
    public class Coordinator {
        let onRefresh: () -> Void
        let isShowing: Binding<Bool>
        
        init(onRefresh: @escaping () -> Void, isShowing: Binding<Bool>) {
            self.onRefresh = onRefresh
            self.isShowing = isShowing
        }
        
        @objc
        func onValueChanged() {
            isShowing.wrappedValue = true
            onRefresh()
        }
    }
    
    public func makeUIView(context: UIViewRepresentableContext<PullToRefresh>) -> UIView {
        let view = UIView(frame: .zero)
        view.isHidden = true
        view.isUserInteractionEnabled = false
        return view
    }
    
    private func tableView(entry: UIView) -> UITableView? {
        
        // Search in ancestors
        if let tableView = Introspect.findAncestor(ofType: UITableView.self, from: entry) {
            return tableView
        }

        guard let viewHost = Introspect.findViewHost(from: entry) else {
            return nil
        }

        // Search in siblings
        return Introspect.previousSibling(containing: UITableView.self, from: viewHost)
    }

    public func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PullToRefresh>) {
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            
            guard let tableView = self.tableView(entry: uiView) else {
                return
            }
            
            if let refreshControl = tableView.refreshControl {
                if self.isShowing {
                    refreshControl.beginRefreshing()
                } else {
                    refreshControl.endRefreshing()
                }
                return
            }
            
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(context.coordinator, action: #selector(Coordinator.onValueChanged), for: .valueChanged)
            tableView.refreshControl = refreshControl
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        return Coordinator(onRefresh: onRefresh, isShowing: $isShowing)
    }
}

extension View {
    public func pullToRefresh(isShowing: Binding<Bool>, onRefresh: @escaping () -> Void) -> some View {
        return overlay(
            PullToRefresh(isShowing: isShowing, onRefresh: onRefresh)
                .frame(width: 0, height: 0)
        )
    }
}

/// Custom ProgressBar View, no built-in progress in swiftui
struct ProgressBar: View {
    @Binding var progress: Float
    var color: Color = .red
    var strokeWidth: CGFloat = 20.0
    var frameSize: CGFloat = 140
    var showNumber = false
    
    private var animation: Animation { .linear }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: self.strokeWidth)
                .opacity(0.3)
                .foregroundColor(self.color)

            Circle()
                .trim(from: 0.0, to: CGFloat(self.progress))
                .stroke(style: StrokeStyle(lineWidth: self.strokeWidth, lineCap: .round, lineJoin: .round))
                .foregroundColor(self.color)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(self.animation)
            if showNumber {
                Text(String(format: "%.0f %%", min(self.progress, 1.0)*100.0))
                    .font(.largeTitle)
                    .bold()
            }
        }
        .frame(width: frameSize, height: frameSize, alignment: .center)
    }
}

/// Binding Wrapper Identifiable for AlertView Changes
public struct AlertBinding: Identifiable {
    public var id: Int
    public var title: String
    public var message: String?
    public var positive: String?
    public var negative: String?
    
    public var positiveAction: (() -> Void)?
    public var negativeAction: (() -> Void)?
    
    public init(_ title: String, message: String?, positive: String?) {
        self.id = title.hashValue
        self.title = title
        self.message = message
        self.positive = positive
    }
}

