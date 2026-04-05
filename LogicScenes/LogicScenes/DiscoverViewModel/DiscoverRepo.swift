//
//  DiscoverRepo.swift
//  LogicScenes
//
//  Created by yusef naser on 03/04/2026.
//
import Combine
import MovieApp_Entites
import MovieApp_Network
import SwiftData
import Foundation

public protocol DiscoverRepoProtocol {
    var isConected: Bool {set get}
    var context: ModelContext? {get set}
    func getDiscover(sort: SortMovies, page: Int) async throws -> EntityDiscoverMovies?
    func getGenerics() async throws -> EntityGenre?
    
    func fetchAllMoviesData() throws -> [MovieDataModel]
    func fetchAllGenericsData() throws -> [GenreDataModel]
}


public class DiscoverRepo : DiscoverRepoProtocol  {
    
    public var context: ModelContext? = nil
    
    var cancellables = Set<AnyCancellable>()
    
    public var isConected: Bool = true
    
    public init() {
        
    }
    
    public func getDiscover(sort : SortMovies , page : Int) async throws -> EntityDiscoverMovies? {
        
        guard isConected else {
            do {
                let allMovies = try fetchAllMoviesData()
                if allMovies.isEmpty {
                    throw NetworkError(code: 1, message: "No Internet, pull to refresh")
                }
                var entityMovies : [EntityMovies] = []
                for movie in allMovies {
                    let genrIds = movie.genres?.compactMap { data in
                        data.id
                    }
                    entityMovies.append(EntityMovies(adult: nil , backdropPath: nil , genreIDS: genrIds , id: movie.id, originalLanguage: nil , originalTitle: movie.originalTitle, overview: movie.overview , popularity: nil , releaseDate: movie.releaseDate , title: movie.title , video: nil , voteAverage: nil , voteCount: nil , posterPath: movie.image))
                }
                return EntityDiscoverMovies(page: 1, results: entityMovies, totalPages: 100, totalResults: 200)
            }catch {
                throw NetworkError(code: 1, message: "No Internet, pull to refresh")
            }

        }
        
        var request = DiscoverRequest()
        request.setSort(sort: sort)
        request.setPage(page: page)
        
        return try await withCheckedThrowingContinuation { continuation in
        
            ApiClient.shared.performRequest(url: request.buildRequest() , type: EntityDiscoverMovies.self )
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
                    
                    self.addMovieData(movies: response.results ?? [])
                    
                }
                .store(in: &cancellables)
        }
       
    }
    
    public func getGenerics() async throws -> EntityGenre?  {
        
        guard isConected else {
            do {
                let allGener = try fetchAllGenericsData()
                if allGener.isEmpty {
                    throw NetworkError(code: 1, message: "No Internet, pull to refresh")
                }
                var entityGenrs : [Genre] = []
                for gen in allGener {
                    
                    entityGenrs.append(Genre(id: gen.id , name: gen.name))
                }
                return EntityGenre(genres: entityGenrs)
            }catch {
                throw NetworkError(code: 1, message: "No Internet, pull to refresh")
            }

        }
        
        let request = GenreRequest()
        
        return try await withCheckedThrowingContinuation { continuation in
        
            ApiClient.shared.performRequest(url: request.buildRequest() , type: EntityGenre.self )
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
                    
                    self.addGenerics(gener: response.genres ?? [])
                    
                }
                .store(in: &cancellables)
        }
        
    }
    
    
    
    func addMovieData(movies: [EntityMovies] )  {

        do {
            let allGenr = try fetchAllGenericsData()
            for movie in movies {
                let filteredItems = allGenr.filter { item in
                    movie.genreIDS?.contains(item.id ?? 0) ?? false
                }
                
                let movie = MovieDataModel(id: movie.id , image: movie.posterPath, budget: nil, genres: filteredItems, originCountry: nil , originalLanguage: nil , originalTitle: movie.originalTitle , overview: movie.overview , releaseDate: movie.releaseDate , revenue: nil , runtime: nil , spokenLanguages: nil , status: nil , tagline: nil , title: movie.title)
                
                context?.insert(movie)
                try context?.save()
            }
        }catch {
            #if DEBUG
            print("Error Saveing Movies")
            #endif
        }
        
        
        
    }

    
    public func fetchAllMoviesData() throws -> [MovieDataModel] {
        let descriptor = FetchDescriptor<MovieDataModel>(sortBy: [SortDescriptor(\.id)])
        return try context?.fetch(descriptor) ?? []
    }
    
    
    func addGenerics(gener: [Genre])  {
        for gen in gener {
            do {
                let generic = GenreDataModel(id: gen.id , name: gen.name)
                context?.insert(generic)
                try context?.save()
            }catch {
                #if DEBUG
                print("error add generics")
                #endif
            }
        }
    }

    
    public func fetchAllGenericsData() throws -> [GenreDataModel] {
        let descriptor = FetchDescriptor<GenreDataModel>(sortBy: [SortDescriptor(\.id)])
        return try context?.fetch(descriptor) ?? []
    }
    
    
}
