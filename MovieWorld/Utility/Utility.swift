//
//  Utility.swift
//  MovieWorld
//
//  Created by Admin on 30.04.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

struct Utility {
    static func stringToDate(dateString: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter.date(from: dateString) ?? Date()
    }
}
