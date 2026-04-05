//
//  DetailsRepo.swift
//  LogicScenes
//
//  Created by yusef naser on 04/04/2026.
//

import Combine
import MovieApp_Network
import MovieApp_Entites
import SwiftData
import Foundation

public protocol DetailsRepoProtocol {
    var isConnected: Bool {set get}
    var context: ModelContext? {get set}
    func getDetailsMovie(id : Int) async throws -> EntityMovie?
    func fetchMovie(by id: Int) throws -> MovieDataModel?
}

public class DetailsRepo : DetailsRepoProtocol {
    
    var cancellables = Set<AnyCancellable>()
    public var isConnected = true
    public var context: ModelContext? = nil
    
    public init () {
        
    }
    
    public func getDetailsMovie(id : Int) async throws -> EntityMovie? {
        
        if !isConnected {
            do {
                guard let item = try fetchMovie(by: id) else {
                    throw NetworkError(code: 1, message: "No data")
                }
                let movie: EntityMovie = EntityMovie(
                    adult: nil,
                    backdropPath: nil,
                    belongsToCollection: nil,
                    budget: item.budget,
                    genres: item.genres?.map{Genre(id:$0.id , name:$0.name)},
                    homepage: nil,
                    id: item.id,
                    imdbID: nil,
                    originCountry: item.originCountry,
                    originalLanguage: item.originalLanguage,
                    originalTitle: item.originalTitle,
                    overview: item.overview,
                    popularity: nil,
                    posterPath: item.image,
                    productionCompanies: nil,
                    productionCountries: nil,
                    releaseDate: item.releaseDate,
                    revenue: item.revenue,
                    runtime: item.runtime,
                    spokenLanguages: nil ,
                    status: item.status,
                    tagline: item.tagline,
                    title: item.title,
                    video: nil,
                    voteAverage: nil,
                    voteCount: nil
                )
                return movie
            } catch {
                throw NetworkError(code: 1, message: "No data")
            }
        }
        
        let request = DetailsMovieRequest(id: id)
        
        return try await withCheckedThrowingContinuation { continuation in
        
            ApiClient.shared.performRequest(url: request.buildRequest() , type: EntityMovie.self )
                .sink { completion in
                    switch completion {
                    case .finished:
                        return
                    case .failure(let error) :
                        continuation.resume(throwing: error)
                        return
                    }
                } receiveValue: { response  in
                    continuation.resume(returning: response)
                }
                .store(in: &self.cancellables)
        }
       
    }
    
    public func fetchMovie(by id: Int) throws -> MovieDataModel? {
        // 1. Create the predicate to match the ID
        let movieID = id
        let descriptor = FetchDescriptor<MovieDataModel>(
            predicate: #Predicate { $0.id == movieID }
        )
        
        // 2. Set fetch limit to 1 since ID is unique
        var fetchDescriptor = descriptor
        fetchDescriptor.fetchLimit = 1
        
        // 3. Return the first result
        return try context?.fetch(fetchDescriptor).first
    }
}

