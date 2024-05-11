//
//  URLSession.swift
//  RickYMortyAlex
//
//  Created by Alex  on 30/4/24.
//

import Foundation

extension URLSession {
    func getData(request: URLRequest) async throws -> (data: Data, response: HTTPURLResponse) {
        let (data, response) = try await data(for: request)
        
        guard let responseHttp = response as? HTTPURLResponse else {
            throw NetworkError.nonHTTP          
        }
        
        return (data, responseHttp)
    }
}
