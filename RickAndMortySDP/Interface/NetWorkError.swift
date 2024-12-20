//
//  NetWorkError.swift
//  RickAndMortySDP
//
//  Created by  on 25/11/24.
//

import Foundation

enum NetWorkError: LocalizedError {
    case nonHTTP
    case badStatusCode(Int)
    case badURLRequest(Error)
    case badJSONDecoder(Error)
    case generalError(Error)
    
    var errorDescription: String {
        switch self {
        case .nonHTTP:
            "Non and HTTP services"
        case .badStatusCode(let statusCode):
            "Bad status code \(statusCode)"
        case .badURLRequest(let error):
            "Bad URL request \(error)"
        case .badJSONDecoder(let error):
            "Failed to the code \(error)"
        case .generalError(let error):
            "General error: \(error)"
        }
    }
}
