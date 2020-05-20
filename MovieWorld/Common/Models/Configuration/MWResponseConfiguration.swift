//
//  MWResponseConfiguration.swift
//  MovieWorld
//
//  Created by Admin on 29.04.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

struct MWResponseConfiguration: Codable {
    let images: MWConfiguration

    enum CodingKeys: String, CodingKey {
      case images
    }
}
