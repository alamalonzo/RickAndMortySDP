//
//  RepositoryMorty.swift
//  RickAndMortySDP
//
//  Created by Alam Alonzo on 25/11/24.
//

import Foundation

protocol ProtocolMorty: Sendable {
    func getRickMortyModel(page: String, name: String, status: CharacterStatus) async throws(NetWorkError) -> RickMortyModel
}

//URL
//DATA
//GESTION DE ERRORES
//DECODE: JSON -> MODEL

struct RepositoryMortyAPI: ProtocolMorty, NetworkRepository {
    func getRickMortyModel(page: String, name: String, status: CharacterStatus) async throws(NetWorkError) -> RickMortyModel {
        try await getJSON(request: .customGet(url: .characterURL(page: page, name: name, status: status)), model: RickMortyModelDTO.self).mapToModel
        
    }
}


