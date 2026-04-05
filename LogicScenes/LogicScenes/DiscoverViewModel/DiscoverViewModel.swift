//
//  DiscoverViewModel.swift
//  LogicScenes
//
//  Created by yusef naser on 03/04/2026.
//

import Foundation
import MovieApp_Entites
import Combine
import SwiftUI

public class DiscoverViewModel : BaseViewModel {
    
    public var repo: DiscoverRepoProtocol
    
    @Published var networkMonitor = NetworkMonitor ()
    
    
    public init(repo: DiscoverRepoProtocol ) {
        self.repo = repo
        super.init()
    }
    @Published public var paginationMovies = PaginationViewModel<EntityMovies>()
    @Published public var genres : [Genre] = []
    @Published public var selectedTags: Set<Genre> = []
    @Published public var searchText = ""
    @Published public var filterdMovies :[EntityMovies] = []
    
    
    @MainActor
    public func fetchAllData () async {
        async let movies = await getDiscoverMovies()
        async let genr = await getGenerics()
        
        let data = await (movies , genr)
        
    }
    
    @MainActor
    public func getDiscoverMovies () async -> [EntityMovies] {
        repo.isConected = networkMonitor.isConnected
        if !repo.isConected {
            self.paginationMovies.resetPagination()
        }
        
        if !paginationMovies.isPaginationAllow() {
            return []
        }
        
        loading = true
        
        do {
           
            
            let data = try await repo.getDiscover(sort: .popularity_desc, page: paginationMovies.currentPage)
            loading = false
            if let movies = data?.results {
                self.paginationMovies.setPaginationData(currentPage: data?.page ?? 1, lastPage: data?.totalPages ?? 0, items: movies)
                self.filterMovies()
            }else {
                loading = false
                self.showAlert(message: "not data exist, pull to refresh")
            }
            
        }catch {
            loading = false
            self.showAlert(message: error.localizedDescription + ", pull to refresh")
        }
        
        return self.paginationMovies.listItems
    }
    
    @MainActor
    public func getGenerics() async -> [Genre]  {
        loading = true
        repo.isConected = networkMonitor.isConnected
        if !repo.isConected {
            self.genres = []
        }
        do {
            let data = try await repo.getGenerics()
            self.genres = data?.genres ?? []
            loading = false
        }catch {
            loading = false
            self.showAlert(message: error.localizedDescription + ", pull to refresh")
        }
        return self.genres
    }
    
    @MainActor
    public func refreshableDiscoverMovies () async {
        paginationMovies.resetPagination()
        await fetchAllData()
    }
    
    @MainActor
    public func loadMoreDiscoverMovies ( movie : EntityMovies ) {
        guard paginationMovies.listItems.last?.id == movie.id else {
            return
        }
        Task {
            await self.getDiscoverMovies()
        }
    }
    
    @MainActor
    public func filterMovies() {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Start with all movies
        var result = paginationMovies.listItems

        // Apply search filter if text exists
        if !query.isEmpty {
            result = result.filter { movie in
                let titleMatch = movie.title?.localizedCaseInsensitiveContains(query) == true
                let originalTitleMatch = movie.originalTitle?.localizedCaseInsensitiveContains(query) == true
                let overviewMatch = movie.overview?.localizedCaseInsensitiveContains(query) == true
                return titleMatch || originalTitleMatch || overviewMatch
            }
        }

        // Apply tag filter if any selected
        if !selectedTags.isEmpty {
            let selectedIDs = selectedTags.compactMap { $0.id }
            result = result.filter { movie in
                guard let movieGenres = movie.genreIDS else { return false }
                // Check if movie has at least one selected genre
                return !Set(movieGenres).isDisjoint(with: selectedIDs)
            }
        }

        // Update filtered movies
        filterdMovies = result
       // return filterdMovies
    }
    
}
