//
//  MWMovieCrew.swift
//  MovieWorld
//
//  Created by Admin on 15.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

class MWMovieCrew: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case cast
        case crew
    }

    let id: Int
    let cast: [MWCast]
    let crew: [MWCrew]

    init(id: Int, cast: [MWCast], crew: [MWCrew]) {
        self.id = id
        self.cast = cast
        self.crew = crew
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = (try? container.decodeIfPresent(Int.self, forKey: .id)) ?? 0
        self.cast = (try? container.decodeIfPresent([MWCast].self, forKey: .cast)) ?? []
        self.crew = (try? container.decodeIfPresent([MWCrew].self, forKey: .crew)) ?? []
    }
}
