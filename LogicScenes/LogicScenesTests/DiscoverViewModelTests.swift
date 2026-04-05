//
//  LogicScenesTests.swift
//  LogicScenesTests
//
//  Created by yusef naser on 04/04/2026.
//

import Testing
import MovieApp_Entites
@testable import LogicScenes
import Foundation
import SwiftData

struct DiscoverViewModelTests {

    var mockRepo = MockDiscoverRepo()
        
    func makeViewModel() -> DiscoverViewModel {
        DiscoverViewModel(repo: mockRepo)
    }
    
    @Test
    func getDiscoverMovies_success_updatesMovies() async {
        
        
//        let mockRepo = MockDiscoverRepo()
        let viewModel = makeViewModel()
        
        let movies = StaticData.movies
        let response = EntityDiscoverMovies(page: 1, results: movies , totalPages: 200, totalResults: 300)
        
        mockRepo.discoverResult = .success(response)
        
        await viewModel.getDiscoverMovies()
        
        #expect(viewModel.paginationMovies.listItems.count == movies.count)
        #expect(viewModel.paginationMovies.listItems.first?.title == "title_1")
        #expect(viewModel.loading == false)
    }

    @Test
    func getDiscoverMovies_failure_setsLoadingFalse() async {
        
        let viewModel = makeViewModel()
        
        mockRepo.discoverResult = .failure(NSError(domain: "", code: 1))
        
        await viewModel.getDiscoverMovies()
        
        #expect(viewModel.paginationMovies.listItems.count == 0)
        #expect(viewModel.loading == false)
    }
    
    
    @MainActor @Test
    func filterMovies_withSearchText_filtersCorrectly() {
        
        let viewModel = makeViewModel()
        
        viewModel.paginationMovies.listItems = StaticData.movies
        viewModel.searchText = "title"
        
        viewModel.filterMovies()
        
        #expect(viewModel.filterdMovies.count == StaticData.movies.count)
        #expect(viewModel.filterdMovies.first?.title == "title_1")
    }
    
    @MainActor @Test
    func filterMovies_withTags_filtersCorrectly() {
        
        let viewModel = makeViewModel()
        
        let genre = Genre(id: 1, name: "Action")
        
        
        viewModel.paginationMovies.listItems = [StaticData.movie_1, StaticData.movie_2]
        viewModel.selectedTags = [genre]
        
        viewModel.filterMovies()
        
        #expect(viewModel.filterdMovies.count == 1)
        #expect(viewModel.filterdMovies.first?.id == 1)
    }
    
    
    @MainActor @Test
    func filterMovies_withSearchAndTags_combinesCorrectly() {
        
        let viewModel = DiscoverViewModel(repo: MockDiscoverRepo())
        
        let genre1 = Genre(id: 1, name: "Action")
        let genre2 = Genre(id: 2, name: "Action")
            
        viewModel.paginationMovies.listItems = [StaticData.movie_1, StaticData.movie_2]
        viewModel.searchText = "title"
        viewModel.selectedTags = [genre1, genre2]
        
        viewModel.filterMovies()
        
        #expect(viewModel.filterdMovies.count == 2)
        #expect(viewModel.filterdMovies.first?.id == 1)
    }
    
}


final class MockDiscoverRepo: DiscoverRepoProtocol {
    
    var isConected: Bool = true
    var context: ModelContext? = nil
    
    func fetchAllMoviesData() throws -> [MovieApp_Entites.MovieDataModel] {
        []
    }
    
    func fetchAllGenericsData() throws -> [MovieApp_Entites.GenreDataModel] {
        []
    }
    
    
    var discoverResult: Result<EntityDiscoverMovies?, Error> = .success(nil)
    var genresResult: Result<EntityGenre?, Error> = .success(nil)
    
    func getDiscover(sort: SortMovies, page: Int) async throws -> EntityDiscoverMovies? {
        try discoverResult.get()
    }
    
    func getGenerics() async throws -> EntityGenre? {
        try genresResult.get()
    }
}
