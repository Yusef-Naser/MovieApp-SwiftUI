//
//  PaginationViewModel.swift
//  UIScenes
//
//  Created by yusef naser on 04/04/2026.
//

import Combine

public class PaginationViewModel <T : Codable> : ObservableObject {
    
    var currentPage = 0
    var lastPage = 1
    public var listItems : [T] = []
    
    public func setPaginationData (currentPage : Int , lastPage : Int , items : [T]) {
        self.currentPage = currentPage
        self.lastPage = lastPage
        self.listItems.append(contentsOf: items)
    }
    
    public func setItems (items : [T] ) {
        self.listItems.append(contentsOf: items)
    }
    
    public func isPaginationAllow () -> Bool {

        if  lastPage > currentPage {
            currentPage += 1
            return true
        }
        return false
    }
    
    public func resetPagination () {
        currentPage = 0
        lastPage = 1
        listItems = []
    }
}
