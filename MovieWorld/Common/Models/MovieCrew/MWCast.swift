//
//  MWCast.swift
//  MovieWorld
//
//  Created by Admin on 14.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit

class MWCast: MWPerson {
    enum CodingKeys: String, CodingKey {
        case character
        case order
        case castId = "cast_id"
    }

    var character: String = ""
    var order: Int = 0
    var castId: Int = 0
    var image: Data? = nil

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.order = (try? container.decodeIfPresent(Int.self, forKey: .order)) ?? 0
        self.character = (try? container.decode(String.self, forKey: .character)) ?? ""
        self.castId = (try? container.decodeIfPresent(Int.self, forKey: .castId)) ?? 0

        try super.init(from: decoder)
    }

    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(self.order, forKey: .order)
        try container.encode(self.character, forKey: .character)
        try container.encode(self.castId, forKey: .castId)

        try super.encode(to: encoder)
    }
}
