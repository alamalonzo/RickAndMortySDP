//
//  RepositoryMorty.swift
//  RickAndMortySDP
//
//  Created by Alam Alonzo on 25/11/24.
//

import Foundation

protocol ProtocolMorty {
    func getRickMortyModel(page: String) async throws -> RickMortyModel
}

//URL
//DATA
//GESTION DE ERRORES
//DECODE: JSON -> MODEL

struct RepositoryMortyAPI: ProtocolMorty, NetworkRepository {
    func getRickMortyModel(page: String) async throws -> RickMortyModel {
        try await getJSON(request: .customGet(url: .characterURL(page: page)), model: RickMortyModelDTO.self).mapToModel
    }
}

