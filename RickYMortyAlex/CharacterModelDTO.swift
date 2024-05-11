//
//  CharacterModelDTO.swift
//  RickYMortyAlex
//
//  Created by Alex  on 25/4/24.
//

import Foundation

// MARK: - ModelDTO
struct CharacterResponseDTO: Codable {
    let info: Info
    let results: [RyMCharacterDTO]
}

// MARK: - Info
struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}

// MARK: - Result
struct RyMCharacterDTO: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let status: Status
    let gender: Gender
    let image: URL
    let episode: [String]
    let created: String
}

enum Gender: String, Codable, CaseIterable, Identifiable {
    var id: Self { self }
    case all = "All"
    case male = "Male"
    case female = "Female"
    case genderless = "Genderless"
    case unknown = "unknown"
    
}

enum Species: String, Codable {
    case alien = "Alien"
    case human = "Human"
    case humanoid = "Humanoid"
    case mythologicalCreature = "Mythological Creature"
    case unknown = "unknown"
    case poopybutthole = "Poopybutthole"
    case animal = "Animal"
}

enum Status: String, Codable {
    case alive = "Alive"
    case unknown = "unknown"
    case dead = "Dead"
}


