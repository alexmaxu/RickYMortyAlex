//
//  PreviewData.swift
//  RickYMortyAlex
//
//  Created by Alex  on 26/4/24.
//

import Foundation

struct TestCharacterInteractor: CharacterInteractorProtocol {
    func fetchCharacters(page: Int, name: String, gender: String) async throws -> CharacterResponseDTO {
        let url = Bundle.main.url(forResource: "RYM", withExtension: "json")!
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(CharacterResponseDTO.self, from: data)
    }
}

extension CharacterListVM {
    static let previewVM = CharacterListVM(interactor: TestCharacterInteractor())
}

extension RyMCharacterDTO {
    static let previewCharacter = RyMCharacterDTO(id: 1, name: "Rick Sanchez Preview", status: .alive, gender: .male, image: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!, episode: [
        "https://rickandmortyapi.com/api/episode/1",
        "https://rickandmortyapi.com/api/episode/2",
        "https://rickandmortyapi.com/api/episode/3"], created: "2017-11-04T18:48:46.250Z")
}
