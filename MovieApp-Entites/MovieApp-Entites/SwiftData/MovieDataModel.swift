//
//  MovieData.swift
//  LogicScenes
//
//  Created by yusef naser on 04/04/2026.
//

import Foundation
import SwiftData

@Model
public final class MovieDataModel {
    @Attribute(.unique)public var id: Int?
    public var image: String?
    public var budget: Int?
    @Relationship(inverse: \GenreDataModel.movies)
    public var genres: [GenreDataModel]?
    public var originCountry: [String]?
    public var originalLanguage : String?
    public var originalTitle : String?
    public var overview : String?
    public var releaseDate : String?
    public var revenue : Int?
    public var runtime : Int?
    public var spokenLanguages : [SpokenLanguageDataModel]?
    public var status: String?
    public var tagline: String?
    public var title: String?
    
    public init(id: Int? = nil, image: String? = nil, budget: Int? = nil, genres: [GenreDataModel]? = nil, originCountry: [String]? = nil, originalLanguage: String? = nil, originalTitle: String? = nil, overview: String? = nil, releaseDate: String? = nil, revenue: Int? = nil, runtime: Int? = nil, spokenLanguages: [SpokenLanguageDataModel]? = nil, status: String? = nil, tagline: String? = nil, title: String? = nil) {
        self.id = id
        self.image = image
        self.budget = budget
        self.genres = genres
        self.originCountry = originCountry
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.releaseDate = releaseDate
        self.revenue = revenue
        self.runtime = runtime
        self.spokenLanguages = spokenLanguages
        self.status = status
        self.tagline = tagline
        self.title = title
    }
}

@Model
public final class GenreDataModel {
    @Attribute(.unique) public var id: Int?
    public var name : String?
    public var movies: [MovieDataModel]?
    
    public init(id: Int? = nil, name: String? = nil) {
        self.id = id
        self.name = name
        self.movies = [] // Initialize as empty array
    }
}

@Model
public final class SpokenLanguageDataModel {
    public var englishName : String?
    public var iso639_1: String?
    public var name: String?
    
    public init(englishName: String? = nil, iso639_1: String? = nil, name: String? = nil) {
        self.englishName = englishName
        self.iso639_1 = iso639_1
        self.name = name
    }
}

