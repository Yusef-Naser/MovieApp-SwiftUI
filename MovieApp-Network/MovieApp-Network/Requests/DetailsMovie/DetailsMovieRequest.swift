//
//  DetailsMovieRequest.swift
//  MovieApp-Network
//
//  Created by yusef naser on 04/04/2026.
//

import Foundation

public struct DetailsMovieRequest : RequestModel {
    
    var id : Int
    public init(id : Int) {
        self.id = id
    }
    public var path: String {
        "movie/\(id)"
    }
    
    public var queries: [URLQueryItem] = []
    
    public var httpMethod: HTTPMethod = .get
    
}
