//
//  URL.swift
//  RickAndMortySDP
//
//  Created by Alam Alonzo on 26/11/24.
//

import Foundation

let mainUrl = URL(string:"https://rickandmortyapi.com/api")!

extension URL {
    static func characterURL(page: String) -> URL {
        mainUrl
            .appending(path: "character")
            .appending(queryItems: [.pageQuery(page: page)])
    }
}

extension URLQueryItem {
    static func pageQuery(page: String) -> URLQueryItem {
        URLQueryItem(name: "page", value: page)
    }
}


