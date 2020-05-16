//
//  MWNetError.swift
//  MovieWorld
//
//  Created by Admin on 16.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

enum MWNetError: Error {
    case incorrectUrl(url: String)
    case networkError(error: Error)
    case serverError(statusCode: Int)
    case parsingError(error: Error)

    case unknown
}
