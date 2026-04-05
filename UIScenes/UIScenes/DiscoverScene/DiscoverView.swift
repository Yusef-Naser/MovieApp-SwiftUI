//
//  DIscoverView.swift
//  UIScenes
//
//  Created by yusef naser on 03/04/2026.
//

import SwiftUI
import LogicScenes
internal import MovieApp_Utilities
import MovieApp_Entites
import SwiftData

public struct DiscoverView : View {
    
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var appRouter: AppRouter
    @StateObject var viewModel: DiscoverViewModel

    public init( viewModel: DiscoverViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        ZStack {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(viewModel.genres, id: \.id) { tag in
                            TagView(tag: tag, isSelected: viewModel.selectedTags.contains(tag) )
                                .onTapGesture {
                                    if viewModel.selectedTags.contains(tag) {
                                        viewModel.selectedTags.remove(tag)
                                    } else {
                                        viewModel.selectedTags.insert(tag)
                                    }
                                    viewModel.filterMovies()
                                }
                        }
                    }
                    .padding(.horizontal)
                }
                ScrollView {
                    LazyVGrid(columns: grid, spacing: 12) {
                        ForEach(viewModel.filterdMovies, id: \.id) { item in
                            MovieCardView(movie: item)
                                .onAppear {
                                    viewModel.loadMoreDiscoverMovies(movie: item)
                                }
                                .onTapGesture {
                                    appRouter.pushTo(.MovieDetails(movie: item))
                                }
                        }
                    }
                    .padding(.horizontal, 12)
                }
                
            }
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
            .onChange(of: viewModel.searchText) {
                viewModel.filterMovies()
            }
            .navigationTitle("Watch New Movies")
            .task {
                // Assign the SwiftData model context once the view is mounted in the hierarchy
                viewModel.repo.context = modelContext
                await viewModel.fetchAllData()
            }
            .refreshable {
                await viewModel.refreshableDiscoverMovies()
            }
            .centralizedAlert(showAlert: $viewModel.showAlert, title: viewModel.alertTitle , message: viewModel.alertMessage )
        }
        viewModel.loadingView()
        
    }
    
    private var grid: [GridItem] {
        [
            GridItem(.flexible(), spacing: 12),
            GridItem(.flexible(), spacing: 12)
        ]
    }
}
