//
//  APIClient.swift
//  MovieApp-Network
//
//  Created by yusef naser on 03/04/2026.
//

import Foundation
import Combine

typealias CompletionSuccess<T : Codable> = (T?) -> Void

public class ApiClient {
    
    private init() {
        
    }
    public static let shared = ApiClient()
    
    public func performRequest <T : Codable > (url : URLRequest ,  type : T.Type ,
                                        decoder: JSONDecoder = JSONDecoder() ) -> AnyPublisher< T , NetworkError> {
        #if DEBUG
        print("Start Request url: \(url.url?.absoluteString ?? "")")
        #endif
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { output -> T in
                
                // Convert the data to a pretty-printed JSON string
                #if DEBUG
                print("ResponseString: (\(T.self)):\n\(String(decoding: output.data, as: UTF8.self))")
                #endif
                let jsonObject = try JSONSerialization.jsonObject(with: output.data, options: [])
                let prettyData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
                guard let prettyString = String(data: prettyData, encoding: .utf8) else {
                    throw NetworkError(code: -1 , message: "invalidResponse")
                }
                #if DEBUG
                print("Response (\(T.self)):\n\(prettyString)")
                #endif
                
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(T.self, from: output.data)
                // Check if response is valid
                guard let httpResponse = output.response as? HTTPURLResponse else {
                    throw NetworkError(code: -1, message: "invalidResponse")
                }
                guard (200...299).contains(httpResponse.statusCode) else {
                    // create error object from statusCode and message
                    throw NetworkError(code: httpResponse.statusCode, message: "InvalidError")
                }

                
                return decodedData
            }
//            .map(\.data)
//            .decode(type: T.self, decoder: decoder )
            .mapError({ error in
                
                if let networkError = error as? NetworkError {
                    return networkError
                }
                
                return NetworkError(code: -1, message: error.localizedDescription )
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
    }
    
}
