//
//  RickMortyModel.swift
//  RickAndMortySDP
//
//  Created by Alam Alonzo on 25/11/24.
//

import Foundation

enum CharacterStatus: String, CaseIterable, Identifiable, Codable {
    case all = "All"
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"

    var id: Self { self }
}

struct RickMortyModel: Codable {
    let info: InfoMortyModel
    let results: [CharacterModel]
}

struct CharacterModel: Codable, Identifiable, Hashable{
    let id: Int
    let name: String
    let status: CharacterStatus
    let species: String
    let gender: String
    let image: URL
    let created: Date
    let origin: CharacterOriginModel
    var isFavorite: Bool
}

struct CharacterOriginModel: Codable, Hashable {
    let name: String
}

struct InfoMortyModel: Codable {
    let pages: Int
    let next: String?
}
