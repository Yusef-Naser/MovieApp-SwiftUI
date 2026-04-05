//
//  AlertModifier.swift
//  MovieApp-Utilities
//
//  Created by yusef naser on 03/04/2026.
//

import SwiftUI

public struct AlertModifier: ViewModifier {
    @Binding var showAlert: Bool
    var alertTitle: String
    var alertMessage: String
    var alertTag : Int = -1
    var action : ((Int)->Void)?
    
    
    public func body(content: Content) -> some View {
        content
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK"), action: {
                    action?(alertTag)
                }))
            }
    }
}

extension View {
    public func centralizedAlert(showAlert: Binding<Bool> , title : String , message: String , alertTag : Int = -1  , action : ((Int)->Void)? = nil ) -> some View {
        self.modifier(AlertModifier(showAlert: showAlert, alertTitle: title, alertMessage: message, alertTag: alertTag  , action: action ))
    }
}
