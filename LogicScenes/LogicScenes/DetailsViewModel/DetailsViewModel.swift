//
//  DetailsViewModel.swift
//  LogicScenes
//
//  Created by yusef naser on 04/04/2026.
//

import MovieApp_Entites
import Combine
import Foundation

public class DetailsViewModel : BaseViewModel {
    
    public var repo : DetailsRepoProtocol
    public var idMovie = 0
    @Published public var movie : EntityMovie?
    @Published public var genres : [Genre] = []
    
    @Published var networkMonitor = NetworkMonitor ()
    
    public init(repo: DetailsRepoProtocol ) {
        self.repo = repo
        super.init()
    }
    
    @MainActor
    public func getDetailsMovie () async {
     
        loading = true
        repo.isConnected = networkMonitor.isConnected

        do {
            let data = try await repo.getDetailsMovie(id: idMovie )
            loading = false
            if let data = data {
                self.movie = data
            }
            
        }catch {
            loading = false
            self.showAlert(message: error.localizedDescription)
        }
        
        
    }
}
