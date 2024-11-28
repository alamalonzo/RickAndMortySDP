//
//  NetworkRepository.swift
//  RickAndMortySDP
//
//  Created by Alam Alonzo on 27/11/24.
//

import Foundation


protocol NetworkRepository {}

extension NetworkRepository {
    func getJSON<Model>(request: URLRequest, model: Model.Type) async throws -> Model where Model: Codable  {
        let (data, response) = try await URLSession.shared.getCustomData(urlRequest: request)
        
        if response.statusCode == 200 {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(.customDateFormatter())
            return try decoder.decode(model, from: data)
        } else {
            throw NetWorkError.badStatusCode(response.statusCode)
        }
    }
}
