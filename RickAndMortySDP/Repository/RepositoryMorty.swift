//
//  RepositoryMorty.swift
//  RickAndMortySDP
//
//  Created by Alam Alonzo on 25/11/24.
//

import Foundation

protocol ProtocolMorty {
    func getRickMortyModel() async throws -> RickMortyModel
}

//URL
//DATA
//GESTION DE ERRORES
//DECODE: JSON -> MODEL

struct RepositoryMortyAPI: ProtocolMorty, NetworkRepository {
    func getRickMortyModel() async throws -> RickMortyModel {
        try await getJSON(request: .customGet(url: .characterURL), model: RickMortyModelDTO.self).mapToModel
    }
}

//func getDemo() async throws -> RickMortyModel {
//    let (data, response) = try await URLSession.shared.getCustomData(urlRequest: URLRequest(url: .characterURL))
//    
//    if httpResponse.statusCode == 200 {
//        //Decodificar el JSON
//        //else: Error -> StatusCode
//    }
//}
