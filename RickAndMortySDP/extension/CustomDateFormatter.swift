//
//  CustomDateFormatter.swift
//  RickAndMortySDP
//
//  Created by  on 26/11/24.
//

import Foundation

extension DateFormatter {
    static func customDateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter
    }
}
