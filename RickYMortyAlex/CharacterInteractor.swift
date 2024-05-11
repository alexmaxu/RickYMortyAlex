//
//  CharacterInteractor.swift
//  RickYMortyAlex
//
//  Created by Alex  on 25/4/24.
//

import Foundation

protocol CharacterInteractorProtocol {
    func fetchCharacters(page: Int, name: String, gender: String) async throws -> CharacterResponseDTO
}

struct CharacterInteractor: CharacterInteractorProtocol, NetworkInteractor {
    
    var session: URLSession
    
    static let shared = CharacterInteractor()
    
    private init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchCharacters(page: Int, name: String, gender: String) async throws -> CharacterResponseDTO {
        try await getJSONFromURL(request: .getURLRequest(url: .getCharacterURL, page: page, name: name, gender: gender), type: CharacterResponseDTO.self)
    }
    
}



// Manera directa de hacer una paticion a red


//protocol OLDCharacterInteractorProtocol {
//    func fetchCharacters() async throws -> CharacterResponseDTO
//}
//
//struct OLDCharacterInteractor: OLDCharacterInteractorProtocol {
//    
//    static let shared = OLDCharacterInteractor()
//    
//    private init() { }
//    
//    func fetchCharacters() async throws -> CharacterResponseDTO {
//        let (data, response) = try await URLSession.shared.data(from: URL(string: "https://rickandmortyapi.com/api/character")!)
//        
//        guard let responsehttp = response as? HTTPURLResponse else {
//            throw NetworkError.nonHTTP
//        }
//        
//        if responsehttp.statusCode == 200 {
//            print("llamada de red")
//            return  try JSONDecoder().decode(CharacterResponseDTO.self, from: data)
//        } else {
//            throw NetworkError.badStatusCode(responsehttp.statusCode)
//        }
//    }
//}



