//
//  URLLanguage.swift
//  MovieWorld
//
//  Created by Admin on 11.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

enum URLLanguage {
    case ru
    case en
    case by

    var rawValue: String {
        switch self {
        case .ru:
            return "Russian"
        case .en:
            return "English"
        case .by:
            return "Russian"
        }
    }

    var urlValue: String {
        switch self {
        case .ru:
            return "ru-RU"
        case .en:
            return "en-US"
        case .by:
            return "ru-BY"
        }
    }
}
