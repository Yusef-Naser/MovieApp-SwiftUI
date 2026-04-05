//
//  NetworkError.swift
//  MovieApp-Network
//
//  Created by yusef naser on 03/04/2026.
//

import Foundation

public class NetworkError: NSError, @unchecked Sendable {
    
    public init (code : Int , message : String) {
        super.init(domain: message , code: code , userInfo: [NSLocalizedDescriptionKey :  message ])
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
