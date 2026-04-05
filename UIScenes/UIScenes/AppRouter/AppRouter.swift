//
//  AppRouter.swift
//  UIScenes
//
//  Created by yusef naser on 04/04/2026.
//

import Combine

@MainActor
public final class AppRouter : ObservableObject {
   
    @Published public var rootPath: [Route] = []
    
    public init () {
        
    }
    func rootPop() {
        if !rootPath.isEmpty {
            rootPath.removeLast()
        }
    }
    
    func popTo (route : Route) {
        if rootPath.contains(route){
            
            while !rootPath.isEmpty &&  rootPath.last != route {
                rootPath.removeLast()
            }
            
        }
    }
    
    func pushTo(_ screen: Route) {
        rootPath.append(screen)
    }
    
    func reset() { rootPath = [] }
    
    func rebaseTo(_ screen: Route) {
        
        rootPath = [screen]
    }
}
