//
//  ContentView.swift
//  MovieApp-SwiftUI
//
//  Created by yusef naser on 03/04/2026.
//

import SwiftUI
import MovieApp_Utilities

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            LoadImage(imageURL: "")
        }
        .padding()
        .onAppear {
            MovieAppUtilities().printValue(value: "test print value in content view -------")
        }
    }
        
}

#Preview {
    ContentView()
}
