//
//  URL.swift
//  RickYMortyAlex
//
//  Created by Alex  on 30/4/24.
//

import Foundation

let mainURL = URL(string: "https://rickandmortyapi.com/api")!

extension URL {
    static let getCharacterURL = mainURL.appending(path: "character")
    
    static func getCharacterByIdURL(id: Int) -> URL {
        getCharacterURL.appending(path: "\(id)")
    }
    
}

