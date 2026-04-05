//
//  EntityGenre.swift
//  MovieApp-Network
//
//  Created by yusef naser on 03/04/2026.
//

public struct EntityGenre : Codable {
    public let genres: [Genre]?
    public init(genres: [Genre]?) {
        self.genres = genres
    }
}

public struct Genre: Codable , Hashable{
    public let id: Int?
    public let name: String?
 
    public init(id: Int?, name: String?) {
        self.id = id
        self.name = name
    }
    
}

