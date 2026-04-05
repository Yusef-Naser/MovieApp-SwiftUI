//
//  MovieApp_SwiftUIApp.swift
//  MovieApp-SwiftUI
//
//  Created by yusef naser on 03/04/2026.
//

import SwiftUI
import UIScenes
import LogicScenes
import MovieApp_Entites
internal import SwiftData

@main
struct MovieApp_SwiftUIApp: App {
    
    @StateObject var appRouter = AppRouter()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appRouter.rootPath) {
                DiscoverView()
                    .navigationDestination(for: Route.self ) { $0 }
            }
            .environmentObject(appRouter)
            .modelContainer(for: [MovieDataModel.self])
            .modelContainer(for: [GenreDataModel.self])
            
        }
    }
}
