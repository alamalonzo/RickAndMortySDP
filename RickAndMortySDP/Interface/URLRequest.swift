//
//  URLRequest.swift
//  RickAndMortySDP
//
//  Created by  on 27/11/24.
//

import Foundation


extension URLRequest {
    static func customGet(url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        return urlRequest
    }
}
