//
//  MWResponseMovie.swift
//  MovieWorld
//
//  Created by Admin on 29.04.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

struct MWResponseMovie: Codable {
    let page: Int
    let results: [MWMovie]
    let totalPages: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

    func hasNextPage() -> Bool {
        return totalPages > page
    }
}
