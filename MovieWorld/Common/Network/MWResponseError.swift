//
//  MWResponseError.swift
//  MovieWorld
//
//  Created by Admin on 17.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

class MWResponseError: Decodable {
    enum CodingKeys: String, CodingKey {
        case code = "status_code"
        case message = "status_message"
    }

    let code: Int
    let message: String

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.code = (try? container.decode(Int.self, forKey: .code)) ?? 400
        self.message = (try? container.decode(String.self, forKey: .message)) ?? "No message"
    }
}
