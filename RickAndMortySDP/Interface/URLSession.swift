//
//  URLSession.swift
//  RickAndMortySDP
//
//  Created by Alam Alonzo on 26/11/24.
//

import Foundation

extension URLSession {
    func getCustomData(urlRequest: URLRequest) async throws -> (Data, HTTPURLResponse) {
        let myTupla = try await URLSession.shared.data(for: urlRequest)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard let httpResponse = response as? HTTPURLResponse else { throw NetWorkError.nonHTTP }
        return (data, httpResponse)
    }
}
