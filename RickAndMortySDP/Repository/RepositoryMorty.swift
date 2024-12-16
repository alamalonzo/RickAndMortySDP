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

/*
 TODO:
 1. Crear local repository
 2. Crear un FavoritesViewModel
 3. Hacer save de favoritos
 4. Hacer que el FavoritesView reaccione a este cambio
 5. Recuperar favoritos de local
 6. Hacer match de los que hay en favs para mostrarlo en el listado de network
 7. Eliminar favorito
 */

