//
//  DetailsViewModelTests.swift
//  LogicScenesTests
//
//  Created by yusef naser on 05/04/2026.
//

import Testing
import MovieApp_Entites
@testable import LogicScenes
import Foundation
import SwiftData

struct DetailsViewModelTests {
    
    private func makeSUT() -> (DetailsViewModel, MockDetailsRepo) {
        let mockRepo = MockDetailsRepo()
        let viewModel = DetailsViewModel(repo: mockRepo)
        return (viewModel, mockRepo)
    }
    
    @Test("Successfully fetching movie details updates the UI state")
    func testGetDetailsMovieSuccess() async throws {
        let (sut, mockRepo) = makeSUT()
    

        let expectedMovie = StaticData.movie_6
        mockRepo.mockMovie = expectedMovie
        sut.idMovie = 7
    

        await sut.getDetailsMovie()
    
        #expect(sut.movie?.title == "Title_6")
        #expect(sut.movie?.id == 7)
        #expect(sut.loading == false)
    }

    @Test("API failure triggers an alert and stops loading")
    func testGetDetailsMovieFailure() async throws {
        let (sut, mockRepo) = makeSUT()
    
       
        mockRepo.shouldReturnError = true
    
        
        await sut.getDetailsMovie()
    
        
        #expect(sut.movie == nil)
        #expect(sut.loading == false)
        #expect(sut.showAlert == true)
    }

    @Test("Network monitor status is correctly passed to the repository")
    func testNetworkStatusSync() async throws {
        let (sut, mockRepo) = makeSUT()
    
        sut.networkMonitor.isConnected = false
    
        
        await sut.getDetailsMovie()
    
        #expect(mockRepo.isConnected == false)
    }
    
    @Test("Initial state is correct", arguments: [0, 10, 99])
    func testInitialIdAssignment(id: Int) async throws {
        let (sut, _) = makeSUT()
        sut.idMovie = id
        #expect(sut.idMovie == id)
    }
}

class MockDetailsRepo: DetailsRepoProtocol {
    var context: ModelContext? = nil
    var isConnected: Bool = true
    var shouldReturnError = false
    var mockMovie = StaticData.movie_6
    
    func fetchMovie(by id: Int) throws -> MovieApp_Entites.MovieDataModel? {
      return nil
    }
    
    func getDetailsMovie(id: Int) async throws -> EntityMovie? {
        if shouldReturnError {
            throw NSError(domain: "TestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "API Error"])
        }
        return mockMovie
    }
}
