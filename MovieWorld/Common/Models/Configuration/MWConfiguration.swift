//
//  MWConfiguration.swift
//  MovieWorld
//
//  Created by Admin on 29.04.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

enum Sizes: String, Codable {    
    case w45
    case w92
    case w154
    case w185
    case w300
    case w342
    case w500
    case h632
    case w780
    case w1280
    case original
}

struct MWConfiguration: Codable {
    enum CodingKeys: String, CodingKey {
        case imageUrl = "base_url"
        case secureImageUrl = "secure_base_url"
        case backdropSizes = "backdrop_sizes"
        case logoSizes = "logo_sizes"
        case posterSizes = "poster_sizes"
        case profileSizes = "profile_sizes"
        case stillSizes = "still_sizes"
    }
    
    var imageUrl: String
    var secureImageUrl: String
    var backdropSizes: [Sizes]
    var logoSizes: [Sizes]
    var posterSizes: [Sizes]
    var profileSizes: [Sizes]
    var stillSizes: [Sizes]
    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//
//        try container.encode(self.imageUrl, forKey: .imageUrl)
//        try container.encode(self.secureImageUrl, forKey: .secureImageUrl)
//        try container.encode(self.backdropSizes, forKey: .backdropSizes)
//        try container.encode(self.logoSizes, forKey: .logoSizes)
//        try container.encode(self.posterSizes, forKey: .posterSizes)
//        try container.encode(self.profileSizes, forKey: .profileSizes)
//        try container.encode(self.stillSizes, forKey: .stillSizes)
//    }
}
