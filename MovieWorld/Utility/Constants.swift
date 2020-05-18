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
    static let point: String = "."
    static let buttonCornerRadius: CGFloat = 5
    static let runtime: String = " minutes"
    static let toDate: String = "  to date, "    
    static let yearsOld: String = " years"


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

    struct Images {
        static let defaultMovie: String = "defaultMovie"
        static let defaultPerson: String = "defaultPerson"
    }

    struct FontSize {
        static let size13: CGFloat = 13
        static let size17: CGFloat = 17
        static let size24: CGFloat = 24
    }

    struct BarIcon {
        static let main: String = "mainBarIcon"
        static let category: String = "categoryBarIcon"
        static let search: String = "searchBarIcon"
    }

    struct BarTitle {
        static let main: String = "Main"
        static let category: String = "Category"
        static let search: String = "Search"
    }
}
