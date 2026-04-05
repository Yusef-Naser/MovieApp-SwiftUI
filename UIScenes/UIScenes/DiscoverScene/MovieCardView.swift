//
//  MovieCardView.swift
//  UIScenes
//
//  Created by yusef naser on 04/04/2026.
//

import SwiftUI
import MovieApp_Entites
internal import MovieApp_Utilities

struct MovieCardView: View {
    
    let movie: EntityMovies?

    var body: some View {
        VStack(alignment: .leading) {
            LoadImage(imageURL: movie?.getPosterPath ?? "")
                .frame(height: 150)
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            Group {
                Text(movie?.title ?? "")
                    .font(.headline)
                Text(year)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
        }
        .frame(height: 200)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            Color.gray.opacity(0.2)
        )
        .cornerRadius(10)
    }


    private var year: String {
        movie?.releaseDate?.prefix(4).description ?? "-"
    }
}

