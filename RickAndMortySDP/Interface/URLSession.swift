//
//  URLSession.swift
//  RickAndMortySDP
//
//  Created by  on 26/11/24.
//

import Foundation

extension URLSession {
    func getCustomData(urlRequest: URLRequest) async throws(NetWorkError) -> (Data, HTTPURLResponse) {
        do {
            let (data, response) = try await data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse else { throw NetWorkError.nonHTTP }
            return (data, httpResponse)
        } catch {
            throw .badURLRequest(error)
        }
    }
}
