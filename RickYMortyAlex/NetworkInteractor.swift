//
//  NetworkInteractor.swift
//  RickYMortyAlex
//
//  Created by Alex  on 30/4/24.
//

import Foundation

protocol NetworkInteractor {
    var session: URLSession { get } // creamos esta variable para poder hacer test y poder mockearlo.
}

extension NetworkInteractor {
    func getJSONFromURL<T>(request: URLRequest, type: T.Type) async throws -> T where T:Codable {
        
        let (data, responseHTTP) = try await session.getData(request: request)
        
        guard responseHTTP.statusCode == 200 else {
            throw NetworkError.badStatusCode(responseHTTP.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(type, from: data)
            
        } catch {
            throw NetworkError.decodingError(error)
        }
        
        
    }
}
