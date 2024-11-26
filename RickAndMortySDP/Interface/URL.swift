//
//  URL.swift
//  RickAndMortySDP
//
//  Created by Alam Alonzo on 26/11/24.
//

import Foundation

let mainUrl = URL(string:"https://rickandmortyapi.com/api")!

extension URL {
    static let characterURL = mainUrl.appending(path: "character")
    
}


