//
//  TagView.swift
//  UIScenes
//
//  Created by yusef naser on 04/04/2026.
//

import SwiftUI
import MovieApp_Entites

struct TagView: View {
    let tag: Genre
    let isSelected: Bool

    var body: some View {
        Text(tag.name ?? "")
            .font(.subheadline)
            .padding(.vertical, 8)
            .padding(.horizontal, 15)
            .background(isSelected ? Color.blue : Color.gray.opacity(0.2))
            .foregroundColor(isSelected ? .white : .black)
            .cornerRadius(20)
            .animation(.easeInOut(duration: 0.2), value: isSelected)
    }
}

