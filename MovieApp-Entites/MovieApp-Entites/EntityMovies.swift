//
//  EntityMovies.swift
//  MovieApp-Network
//
//  Created by yusef naser on 03/04/2026.
//

public struct EntityMovies : Codable {
    let adult: Bool?
    let backdropPath: String?
    public let genreIDS: [Int]?
    public let id: Int?
    let originalLanguage: String?
    public let originalTitle, overview: String?
    let popularity: Double?
    public let releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    public let posterPath : String?
    public var getPosterPath : String? {
        if let path = posterPath , path.count > 0 {
            return "https://image.tmdb.org/t/p/w500\(posterPath ?? "")"
        }
        return nil
    }
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    
    public init(adult: Bool?, backdropPath: String?, genreIDS: [Int]?, id: Int?, originalLanguage: String?, originalTitle: String?, overview: String?, popularity: Double?, releaseDate: String?, title: String?, video: Bool?, voteAverage: Double?, voteCount: Int?, posterPath: String?) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.genreIDS = genreIDS
        self.id = id
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.releaseDate = releaseDate
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.posterPath = posterPath

    }
    
}
