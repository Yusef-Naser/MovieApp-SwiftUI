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
                #if DEBUG
                print("\(viewName) appeared")
                #endif
            }
            .onDisappear {
#if DEBUG
                print("\(viewName) disappeared")
#endif
            }
    }
}

extension View {
    public func debug(_ name: String) -> some View {
        self.modifier(DebugViewModifier(viewName: name))
    }
}
