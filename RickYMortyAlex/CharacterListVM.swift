//
//  CharacterListVM.swift
//  RickYMortyAlex
//
//  Created by Alex  on 26/4/24.
//

import Foundation
enum CharacterListViewStatus {
    case loading
    case loaded
    case error
}

final class CharacterListVM: ObservableObject {
    
    let interactor: CharacterInteractorProtocol
    
    @Published var characters: [RyMCharacterDTO] = []
    @Published var filter: Gender = .all {
        didSet {
            
            characters.removeAll()
            page = 1
            Task {
                await getCharacters()
            }
        }
    }
    
    @Published var searchText = "" {
        didSet {
            page = 1
        }
    }
    
    var page = 1
    var isLastPage = false
    @Published var viewStatus: CharacterListViewStatus = .loading

    init(interactor: CharacterInteractorProtocol = CharacterInteractor.shared) {
        self.interactor = interactor
        Task {
            await getCharacters()
        }
    }
    
    func getCharacters() async {
        await MainActor.run {
        viewStatus = .loading
            if page == 1 {
                characters.removeAll()
            }
        }
    
        do {

            let charactersResult = try await interactor.fetchCharacters(page: page, name: searchText, gender: filter == .all ? "" : filter.rawValue )
            
            await MainActor.run {
                self.characters += charactersResult.results
                isLastPage = charactersResult.info.next == nil
                viewStatus = .loaded
            }
        } catch {
            print(error)
            await MainActor.run {
                if searchText.isEmpty {
                    viewStatus = .error
                } else {
                    viewStatus = .loaded
                }
            }
        
        }
    }
    
    func nextPageCharacters(id: Int) async {
        if characters.last?.id == id && !isLastPage {
            page += 1
            Task {
                await getCharacters()
            }
        }
    }
}


