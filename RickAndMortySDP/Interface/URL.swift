//
//  URL.swift
//  RickAndMortySDP
//
//  Created by Alam Alonzo on 26/11/24.
//

import Foundation
//URL BASE
let mainUrl = URL(string:"https://rickandmortyapi.com/api")!

extension URL {
    //ENDPOINT 1
    static func characterURL(page: String, name: String, status: CharacterStatus) -> URL {
        mainUrl
            .appending(path: "character")
            .appending(queryItems: [.pageQuery(page: page),
                                    .nameQuery(name: name),
                                    .statusQuery(status: status)])
    }
    
}

extension URLQueryItem {
    static func pageQuery(page: String) -> URLQueryItem {
        URLQueryItem(name: "page", value: page)
    }
    static func nameQuery(name: String) -> URLQueryItem {
        URLQueryItem(name: "name", value: name)
    }
    static func statusQuery(status: CharacterStatus) -> URLQueryItem {
        let statusString = switch status {
        case .all: ""
        case .alive: status.rawValue
        case .dead: status.rawValue
        case .unknown: status.rawValue
        }
        return URLQueryItem(name: "status", value: statusString)
        
        //Old way
        /*
         var statusString = ""
         switch status {
         case .all:
         statusString = ""
         case .alive:
         statusString = status.rawValue
         case .dead:
         statusString = status.rawValue
         case .unknown:
         statusString = status.rawValue
         }
         */
    }
}


