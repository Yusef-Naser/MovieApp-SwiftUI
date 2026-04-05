//
//  CustomProgress.swift
//  MovieApp-Utilities
//
//  Created by yusef naser on 03/04/2026.
//

import SwiftUI

public struct CustomProgress: View {
    
    @State private var loadingText: String = "Loading"
    private let loadingStates = ["Loading...", "Loading.", "Loading.."]
    @State private var currentIndex = 0
    @State private var timer: Timer? // Store the Timer instance
    
    public init() {
        
    }
    
    public var body: some View {
        ZStack {
            // Background view
            Color.white
                .opacity(0.5)
                .ignoresSafeArea()

            // Progress view in the center
            VStack {
                Spacer()
                Text(loadingText)
                Spacer()
            }
            .onAppear {
                // Timer to cycle through loading texts
                timer = Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true) { timer in
                    currentIndex = (currentIndex + 1) % loadingStates.count
                    loadingText = loadingStates[currentIndex]
                }
            }
            .onDisappear(perform: {
                timer?.invalidate()
                timer = nil
            })
        }
    }
}

