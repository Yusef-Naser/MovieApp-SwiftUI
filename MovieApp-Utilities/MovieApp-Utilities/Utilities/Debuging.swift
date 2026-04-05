//
//  Debuging.swift
//  MovieApp-Utilities
//
//  Created by yusef naser on 03/04/2026.
//

import SwiftUI

public struct DebugViewModifier: ViewModifier {
    let viewName: String

    public func body(content: Content) -> some View {
        content
            //.navigationBarHidden(true)
            .onAppear {
                print("\(viewName) appeared")
            }
            .onDisappear {
                print("\(viewName) disappeared")
            }
    }
}

extension View {
    public func debug(_ name: String) -> some View {
        self.modifier(DebugViewModifier(viewName: name))
    }
}
