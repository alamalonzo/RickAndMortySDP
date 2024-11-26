//
//  NetWorkError.swift
//  RickAndMortySDP
//
//  Created by Alam Alonzo on 25/11/24.
//

import Foundation

enum NetWorkError: LocalizedError {
    case nonHTTP
    case badStatusCode(Int)
    
    var errorDescription: String? {
        switch self {
        case .nonHTTP:
            "Non and HTTP services"
        case .badStatusCode(let statusCode):
            "badStatusCode \(statusCode)"
        }
    }
}
