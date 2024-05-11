//
//  NetworkError.swift
//  RickYMortyAlex
//
//  Created by Alex  on 26/4/24.
//

import Foundation

enum NetworkError: LocalizedError {
    case nonHTTP
    
    case badStatusCode(Int)
    
    case decodingError(Error)
    
    var errorDescription: String {
        switch self {
        case .nonHTTP:
            "No es una conexion HTTP"
        case .badStatusCode(let statusCode):
            "Error de Status \(statusCode)"
        case .decodingError(let JsonError):
            "Error \(JsonError)"
        }
    }
}
