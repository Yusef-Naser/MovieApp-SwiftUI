//
//  Route.swift
//  UIScenes
//
//  Created by yusef naser on 04/04/2026.
//

import Foundation
import SwiftUI
internal import MovieApp_Utilities
import MovieApp_Entites
import LogicScenes

public enum Route {
    case DiscoverScene
    case MovieDetails(movie: EntityMovies)
}

extension Route : View {
    
    public var body: some View {
        switch self {
        case .DiscoverScene:
            return AnyView(
                DiscoverView()
                    .debug("DiscoverView")
            )
        case .MovieDetails(let movie):
            let viewModel = DetailsViewModel()
            viewModel.idMovie = movie.id ?? 0
            return AnyView(
                MovieDetailsView(viewModel: viewModel)
                    .debug("MovieDetailsView")
            )
        }
    }
    
}

extension Route : Hashable {
    public static func == (lhs: Route, rhs: Route) -> Bool {
        switch (lhs, rhs) {
        case (.DiscoverScene, .DiscoverScene):
            return true
        case let (.MovieDetails(l), .MovieDetails(r)):
            return l.id == r.id
        default:
            return false
        }
    }

    public func hash(into hasher: inout Hasher) {
        switch self {
        case .DiscoverScene:
            hasher.combine(0)
        case .MovieDetails(let movie):
            hasher.combine(1)
            hasher.combine(movie.id)
        }
    }
}
