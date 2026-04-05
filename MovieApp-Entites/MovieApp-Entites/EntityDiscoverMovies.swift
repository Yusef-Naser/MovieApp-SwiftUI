//
//  EntityDiscoverMovies.swift
//  MovieApp
//
//  Created by yusef naser on 29/01/2024.
//

public struct EntityDiscoverMovies : Codable {
    public let page: Int?
    public let results: [EntityMovies]?
    public let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    public init(page: Int?, results: [EntityMovies]?, totalPages: Int?, totalResults: Int?) {
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }

}
