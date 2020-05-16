//
//  MWCrew.swift
//  MovieWorld
//
//  Created by Admin on 14.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

class MWCrew: MWPerson {
    enum CodingKeys: String, CodingKey {
        case department
        case job
    }

    var department: String = ""
    var job: String = ""

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.department = (try? container.decodeIfPresent(String.self, forKey: .department)) ?? ""
        self.job = (try? container.decode(String.self, forKey: .job)) ?? ""

        try super.init(from: decoder)
    }

    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(self.department, forKey: .department)
        try container.encode(self.job, forKey: .job)

        try super.encode(to: encoder)
    }
}
