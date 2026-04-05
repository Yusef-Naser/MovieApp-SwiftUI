//
//  StaticData.swift
//  LogicScenesTests
//
//  Created by yusef naser on 04/04/2026.
//

import MovieApp_Entites

struct StaticData {
    
    static var movie_1 = EntityMovies(adult: false , backdropPath: "backdropPath_1", genreIDS: [1, 2 , 3], id: 1, originalLanguage: "en", originalTitle: "originalTitle_1", overview: "overview_1", popularity: 2.5 , releaseDate: "releaseDate_1", title: "title_1", video: false, voteAverage: nil , voteCount: nil , posterPath: "posterPath_1")
    
    static let movie_2 = EntityMovies(adult: false, backdropPath: "backdropPath_2", genreIDS: [2,3], id: 2, originalLanguage: "en", originalTitle: "originalTitle_2", overview: "overview_2", popularity: 3.5, releaseDate: "releaseDate_2", title: "title_2", video: false, voteAverage: nil, voteCount: nil, posterPath: "posterPath_2")

    static let movie_3 = EntityMovies(adult: false, backdropPath: "backdropPath_3", genreIDS: [1], id: 3, originalLanguage: "en", originalTitle: "originalTitle_3", overview: "overview_3", popularity: 4.0, releaseDate: "releaseDate_3", title: "title_3", video: false, voteAverage: nil, voteCount: nil, posterPath: "posterPath_3")

    static let movie_4 = EntityMovies(adult: false, backdropPath: "backdropPath_4", genreIDS: [3], id: 4, originalLanguage: "en", originalTitle: "originalTitle_4", overview: "overview_4", popularity: 1.5, releaseDate: "releaseDate_4", title: "title_4", video: false, voteAverage: nil, voteCount: nil, posterPath: "posterPath_4")

    static let movie_5 = EntityMovies(adult: false, backdropPath: "backdropPath_5", genreIDS: [1,2], id: 5, originalLanguage: "en", originalTitle: "originalTitle_5", overview: "overview_5", popularity: 5.0, releaseDate: "releaseDate_5", title: "title_5", video: false, voteAverage: nil, voteCount: nil, posterPath: "posterPath_5")
    
    
    static let movies: [EntityMovies] = [
        movie_1,
        movie_2,
        movie_3,
        movie_4,
        movie_5
    ]
    
}
