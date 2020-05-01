//
//  MWCountry.swift
//  MovieWorld
//
//  Created by Admin on 30.04.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

struct MWCountry: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "iso_3166_1"
        case name
    }
    
    let id: String
    let name: String
}
