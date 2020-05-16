//
//  MWPerson.swift
//  MovieWorld
//
//  Created by Admin on 14.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

class MWPerson: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case creditId = "credit_id"
        case name
        case gender
        case profilePath = "profile_path"
    }

    let id: Int?
    let creditId: Int?
    let name: String?
    let gender: Int?
    let profilePath: String?

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = (try? container.decodeIfPresent(Int.self, forKey: .id)) ?? 0
        self.name = (try? container.decode(String.self, forKey: .name)) ?? ""
        self.creditId = (try? container.decodeIfPresent(Int.self,
                                                        forKey: .creditId))
        self.gender = try? container.decodeIfPresent(Int.self,
                                                     forKey: .gender)
        self.profilePath = try? container.decodeIfPresent(String.self,
                                                          forKey: .profilePath)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.creditId, forKey: .creditId)
        try container.encode(self.gender, forKey: .gender)
        try container.encode(self.profilePath, forKey: .profilePath)
    }
}
