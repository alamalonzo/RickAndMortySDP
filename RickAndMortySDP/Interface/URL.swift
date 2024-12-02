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
    static func characterURL(page: String, name: String) -> URL {
        mainUrl
            .appending(path: "character")
            .appending(queryItems: [.pageQuery(page: page),
                                    .nameQuery(name: name)])
    }
    
}

extension URLQueryItem {
    static func pageQuery(page: String) -> URLQueryItem {
        URLQueryItem(name: "page", value: page)
    }
    static func nameQuery(name: String) -> URLQueryItem {
        URLQueryItem(name: "name", value: name)
    }
}


