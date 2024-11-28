//
//  RickMortyModelDTO.swift
//  RickAndMortySDP
//
//  Created by Alam Alonzo on 25/11/24.
//

import Foundation


struct RickMortyModelDTO: Codable {
    let info: InfoMortyDTO
    let results: [CharacterDTO]
    
    var mapToModel: RickMortyModel {
        RickMortyModel(
            info: info.mapToModel,
            results: results.map(\.mapToModel)
        )
    }
}

struct CharacterDTO: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: URL
    let created: Date
    let origin: CharacterOriginDTO
    
    var mapToModel: CharacterModel {
        CharacterModel(
            id: id,
            name: name,
            status: status,
            species: species,
            gender: gender,
            image: image,
            created: created,
            origin: origin.mapToModel,
            isFavorite: false
        )
    }
}

struct CharacterOriginDTO: Codable {
    let name: String
    
    var mapToModel: CharacterOriginModel {
        CharacterOriginModel(name: name)
    }
}

struct InfoMortyDTO: Codable {
    let pages: Int
    let next: String?
    
    var mapToModel: InfoMortyModel {
        InfoMortyModel(
            pages: pages,
            next: next
        )
    }
}
