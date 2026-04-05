//
//  RequestModel.swift
//  MovieApp-Network
//
//  Created by yusef naser on 03/04/2026.
//

import Foundation
import MovieApp_Utilities

public enum HTTPMethod : String {
    case post
    case get
}

public protocol RequestModel {
    
    var path : String { get }
    var queries : [URLQueryItem] {get}
    var httpMethod : HTTPMethod {get}
    
}

public extension RequestModel {
    
    var headers : [String: String]  {
        [
          "accept": "application/json",
          "Authorization": "Bearer \(Constants.API_KEY)"
        ]
    }
    func buildRequest() -> URLRequest {
        
        let queryItems = queries
        var urlComps = URLComponents(string: Constants.URL + self.path)!
        urlComps.queryItems = queryItems
        var urlRequest = URLRequest(url: urlComps.url! )
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpMethod = self.httpMethod.rawValue
        return urlRequest
    }
}
