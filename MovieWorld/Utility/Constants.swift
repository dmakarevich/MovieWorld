//
//  Constants.swift
//  MovieWorld
//
//  Created by Admin on 30.04.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

struct Constants {
    static let emptyString: String = ""
    static let commaDelimiter: String = ", "
    
    struct NCNames {
        static let categories = Notification.Name("GenresMovie")
    }
    
    struct MainTableHeader {
        static let reuseIdentifier: String = "MWMainTableHeader"
        static let allButton: String = "All →"
        static let nameCategory: String = "Header"
    }
    
    struct Colors {
        static let accentColor: String = "accentColor"
        static let textColor: String = "textColor"
    }
    
    struct FontSize {
        static let size13: CGFloat = 13
        static let size17: CGFloat = 17
        static let size24: CGFloat = 24
    }
}
