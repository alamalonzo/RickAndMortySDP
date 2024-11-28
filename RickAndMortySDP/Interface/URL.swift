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
    static let characterURL = mainUrl.appending(path: "character")
    
}


