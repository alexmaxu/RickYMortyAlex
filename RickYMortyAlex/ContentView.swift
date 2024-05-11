//
//  ContentView.swift
//  RickYMortyAlex
//
//  Created by Alex  on 25/4/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var vm = CharacterListVM()
    
    var body: some View {
        NavigationStack {
            Group {
                switch vm.viewStatus {
                case .loading:
                    ProgressView()
                        .controlSize(.extraLarge)
                case .loaded:
                    List {
                        if vm.characters.isEmpty {
                            ContentUnavailableView("No existe", systemImage: "iphone", description: Text("No se existe \(vm.searchText)"))
                        }
                        ForEach(vm.characters) { character in
                            NavigationLink (value: character) {
                                CharacterCell(character: character)
                                    .onAppear {
                                        Task {
                                            await vm.nextPageCharacters(id: character.id)
                                        }
                                    }
                            }
                        }
                    }
                case .error:
                    CustomAlertView(alertDescription: "Something is going wrong!", alertTitle: "Caution!", buttonText: "Button") {
                        vm.viewStatus = .loaded
                    }
                }
            }
            .navigationTitle("Characters List")
            .navigationDestination(for: RyMCharacterDTO.self) { character in
                Text(character.name)
            }
            .searchable(text: $vm.searchText, placement: .automatic, prompt: "Search")
            .onChange(of: vm.searchText) { oldValue, newValue in
                Task {
                    try await Task.sleep(for: .seconds(1))
                    if newValue == vm.searchText && newValue != "" {
                        await vm.getCharacters()
                    }
                }
                
                if newValue == "" {
                    vm.filter = .all
                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Picker("hola", selection: $vm.filter) {
                        ForEach(Gender.allCases) { filter in
                            Text(filter.rawValue.capitalized)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView(vm: .previewVM)
}

