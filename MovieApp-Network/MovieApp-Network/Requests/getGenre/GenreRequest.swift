//
//  GenreRequest.swift
//  MovieApp-Network
//
//  Created by yusef naser on 03/04/2026.
//

import Foundation

public struct GenreRequest : RequestModel {
    
    public init() {
        
    }

    public var path: String = "genre/movie/list"
    
    public var queries: [URLQueryItem] = []
    
    public var httpMethod: HTTPMethod = .get
    
    
    
}
