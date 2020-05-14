//
//  MWCategory.swift
//  MovieWorld
//
//  Created by Admin on 11.04.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

class MWCategory: Codable {
    //MARK: - Enums
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }

    //MARK: - Variables
    let id: Int
    let name: String

    //MARK: - Initialization
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = (try? container.decode(Int.self, forKey: .id)) ?? 0
        self.name = (try? container.decode(String.self, forKey: .name)) ?? Constants.emptyString
    }

    //MARK: - Encoding Methods
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
    }
}
