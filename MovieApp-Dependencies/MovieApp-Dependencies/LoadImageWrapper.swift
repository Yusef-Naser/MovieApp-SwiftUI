//
//  MovieApp_Dependencies.swift
//  MovieApp-Dependencies
//
//  Created by yusef naser on 03/04/2026.
//

import SwiftUI
import SDWebImageSwiftUI

public struct LoadImageWrapper : View {
    
    public init(imageURL: String?) {
        self.imageURL = imageURL
    }
    
    let imageURL : String?
    
    public var body: some View {
        
        if let imageURL = imageURL {
            WebImage(url: URL(string: imageURL)) { image in
                image
                    .resizable()
            } placeholder: {
                EmptyView()
                    .background {
                        Color.gray.opacity(0.5)
                    }
            }
            .indicator(.activity) // Activity Indicator
            .transition(.fade(duration: 0.5)) // Fade Transition with duration
        }else {
            EmptyView()
                .background {
                    Color.gray.opacity(0.5)
                }
        }

    }
    
}

