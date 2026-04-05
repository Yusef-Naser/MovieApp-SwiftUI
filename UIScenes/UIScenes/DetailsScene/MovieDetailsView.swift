//
//  DetailsView.swift
//  UIScenes
//
//  Created by yusef naser on 04/04/2026.
//

import SwiftUI
import MovieApp_Entites
internal import MovieApp_Utilities
import LogicScenes

struct MovieDetailsView : View {
    
    @EnvironmentObject var appRouter : AppRouter
    @StateObject var viewModel: DetailsViewModel
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading ) {
                    LoadImage(imageURL: viewModel.movie?.getPosterPath ?? "")
                        .frame(height: 250)
                        .frame(maxWidth: .infinity)
                        .clipped()
                        .ignoresSafeArea(edges: .top)
                    
                    HStack {
                        LoadImage(imageURL: viewModel.movie?.getPosterPath ?? "")
                            .frame(width: 100, height: 150)
                            .cornerRadius(5)
                            .padding([.leading , .top , .bottom] , 8)
                        
                        VStack (alignment: .leading){
                            Text("\(viewModel.movie?.title ?? "")\("(\(year))")")
                                .padding(.top , 4 )
                                .font(.system(size: 20, weight: .semibold))
                            
                            Text(
                                viewModel.movie?.genres?
                                    .map { $0.name ?? "" }
                                    .joined(separator: ", ")
                                ?? ""
                            )
                            .font(.system(size: 15, weight: .light))
                            Spacer()
                        }
                        .padding(.leading , 8)
                        
                    }
                    
                    Text(viewModel.movie?.overview ?? "")
                        .padding([.leading , .trailing] , 8)
                        .font(.system(size: 15, weight: .regular))
                    
                    if let homepage = viewModel.movie?.homepage, let url = URL(string: homepage), !homepage.isEmpty {
                        HStack(alignment: .firstTextBaseline, spacing: 4) {
                            Text("Home Page:")
                                .font(.system(size: 15, weight: .semibold))
                            Link(homepage, destination: url)
                                .foregroundStyle(.blue)
                                .font(.system(size: 15, weight: .regular))
                        }
                        .padding([.top , .leading , .trailing] , 10)
                    } else {
                        Text("Home Page: -")
                            .font(.system(size: 15, weight: .semibold))
                            .padding([.top , .leading , .trailing] , 10)
                    }
                    
                    viewProperties(title: "Language:", value: (viewModel.movie?.spokenLanguages?.compactMap { $0.name }.joined(separator: ", ") ?? ""))
                        .padding([.leading, .trailing] , 10)
                    
                    HStack {
                        
                        viewProperties(title: "Status:", value: viewModel.movie?.status ?? "")
                        Spacer()
                        viewProperties(title: "Runtime:", value: "\(viewModel.movie?.runtime ?? 0)")
                        
                    }
                    .padding([.leading, .trailing] , 10)
                    
                    HStack {
                        
                        viewProperties(title: "Budget:", value: "\(viewModel.movie?.budget ?? 0)$")
                        Spacer()
                        viewProperties(title: "Revenue:", value: "\(viewModel.movie?.revenue ?? 0)$")
                        
                    }
                    .padding([.leading, .trailing] , 10)
                    
                    Spacer()
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                viewModel.repo.context = modelContext
                await viewModel.getDetailsMovie()
            }
            viewModel.loadingView()
        }
    }
    
    private var year: String {
        viewModel.movie?.releaseDate?.prefix(4).description ?? "-"
    }
    
    @ViewBuilder
    func viewProperties(title : String , value : String) -> some View{
        HStack(alignment: .firstTextBaseline, spacing: 4) {
            Text(title)
                .font(.system(size: 15, weight: .semibold))
            Text(value)
                .font(.system(size: 15, weight: .regular))
        }
    }
    
    
}
