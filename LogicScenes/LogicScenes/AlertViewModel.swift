//
//  AlertViewModel.swift
//  LogicScenes
//
//  Created by yusef naser on 03/04/2026.
//

import SwiftUI
import Combine

public class AlertViewModel: ObservableObject {
    
    @Published public var showAlert: Bool = false
    @Published public var alertTitle: String = ""
    @Published public var alertMessage: String = ""
    var alertTag : Int = -1
    
    public init () {
        
    }
    
    func showAlert(title : String = "Alert" ,message: String , tag : Int = -1 ) {
        self.alertTitle = title
        self.alertMessage = message
        self.showAlert = true
        self.alertTag = tag
        
    }
}
