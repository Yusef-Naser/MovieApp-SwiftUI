//
//  DiscoverRequest.swift
//  MovieApp
//
//  Created by yusef naser on 29/01/2024.
//

import Foundation
import MovieApp_Entites

public struct DiscoverRequest : RequestModel {
    
    public init() {
        
    }
    
    public var path: String = "discover/movie"
    
    public var queries: [URLQueryItem] = [
        URLQueryItem(name: "include_adult", value: "false"),
        URLQueryItem(name: "language", value: "en-US"),
    ]
    
    public var httpMethod: HTTPMethod = .get
    
    
    public mutating func setSort (sort : SortMovies) {
        queries.removeAll { item in
            item.name == "sort_by"
        }
        queries.append(URLQueryItem(name: "sort_by" , value: sort.rawValue ))
    }
    
    public mutating func setPage (page : Int) {
        queries.removeAll { item in
            item.name == "page"
        }
        queries.append(URLQueryItem(name: "page", value: "\(page)"))
        
    }
    
}
