//
//  LoadImage.swift
//  MovieApp-Utilities
//
//  Created by yusef naser on 03/04/2026.
//

import SwiftUI
import MovieApp_Dependencies

public struct LoadImage: View {
    
    let imageURL : String?
    
    public init(imageURL: String?) {
        self.imageURL = imageURL
    }
    
    public var body: some View {
        
        LoadImageWrapper(imageURL: imageURL)
            .scaledToFill()
            
       
    }
}
