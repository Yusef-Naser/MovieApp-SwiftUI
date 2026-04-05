//
//  BaseViewModel.swift
//  LogicScenes
//
//  Created by yusef naser on 03/04/2026.
//

import Combine
import SwiftUI
import MovieApp_Utilities

public class BaseViewModel : AlertViewModel {
    
    @Published var loading = false
    @Published var showContentUnavailableView = false
    
    public override init () {
        
    }
    
    @ViewBuilder
    public func loadingView () -> some View{
        if loading {
            CustomProgress()
        }else {
            EmptyView()
        }
        
    }
    
}
