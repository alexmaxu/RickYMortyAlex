//
//  URLRequest.swift
//  RickYMortyAlex
//
//  Created by Alex  on 2/5/24.
//

import Foundation

enum HTTPMethod: String {
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
    case get = "GET"
}


extension URLRequest {
    // Si no ponemos el static, se puede utilizar la funcion en el interactor? con un URLRquest.getURLRequest? 
    static func getURLRequest(url: URL, page: Int, name: String, gender: String) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.url?.append(queryItems: [.page(page), .name(name), .gender(gender)])
        print(request)
        return request
    }
}

extension URLQueryItem {
    static func page(_ page: Int) -> URLQueryItem {
        return URLQueryItem(name: "page", value: "\(page)")
    }
    static func name(_ name: String) -> URLQueryItem {
        return URLQueryItem(name: "name", value: "\(name)")
    }
    static func gender(_ gender: String) -> URLQueryItem {
        return URLQueryItem(name: "gender", value: "\(gender)")
    }
}
