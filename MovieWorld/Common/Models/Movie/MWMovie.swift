//
//  MWMovie.swift
//  MovieWorld
//
//  Created by Admin on 17.04.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

class MWMovie: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case categoryIds = "genre_ids"
        case description = "overview"
        case releaseDate = "release_date"
        case adult
        case poster = "poster_path"
        case backdropPath = "backdrop_path"
    }

    let id: Int
    let title: String
    let originalTitle: String
    let originalLanguage: String
    let categoryIds: [Int]
    let description: String
    let releaseDate: Date
    let adult: Bool
    let poster: String
    let backdropPath: String
    var image: Data? = nil

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = (try? container.decode(Int.self, forKey: .id)) ?? 0
        self.title = (try? container.decode(String.self, forKey: .title)) ?? Constants.emptyString
        self.originalTitle = (try? container.decode(String.self, forKey: .originalTitle)) ?? Constants.emptyString
        self.originalLanguage = (try? container.decode(String.self, forKey: .originalLanguage)) ?? Constants.emptyString
        self.categoryIds = (try? container.decode([Int].self, forKey: .categoryIds)) ?? []
        self.description = (try? container.decode(String.self, forKey: .description)) ?? Constants.emptyString
        let date = (try? container.decode(String.self, forKey: .releaseDate)) ?? Constants.emptyString
        self.releaseDate = Utility.stringToDate(dateString: date)
        self.adult = (try? container.decode(Bool.self, forKey: .adult)) ?? false
        self.poster = (try? container.decode(String.self, forKey: .poster)) ?? Constants.emptyString
        self.backdropPath = (try? container.decode(String.self, forKey: .backdropPath)) ?? Constants.emptyString
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(self.id, forKey: .id)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.originalTitle, forKey: .originalTitle)
        try container.encode(self.originalLanguage, forKey: .originalLanguage)
        try container.encode(self.categoryIds, forKey: .categoryIds)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.releaseDate, forKey: .releaseDate)
        try container.encode(self.adult, forKey: .adult)
        try container.encode(self.poster, forKey: .poster)
        try container.encode(self.backdropPath, forKey: .backdropPath)
    }

    //MARK: - Methods for prepare info to display
    func getSubtitle() -> String {
        var result = ""
        if let year = self.getReleaseYear() {
            result += year + Constants.commaDelimiter
        }
        result += self.getFirstCategory()

        return result
    }

    func getCategoryString() -> String {
        var result: String = Constants.emptyString
        if let categories = MWSys.sh.movieGenres, categories.count > 0 {
            self.categoryIds.forEach({ (id) in
                categories.forEach({ (category) in
                    if category.id == id {
                        result += self.categoryIds.first != id ? Constants.commaDelimiter : ""
                        result += category.name
                    }
                })
            })
        }

        return result
    }

    func getReleaseYear() -> String? {
        var result: String?
        if let year = Calendar.current.dateComponents([.year], from: self.releaseDate).year {
            result = String(year)
        }

        return result
    }

    func getFirstCategory() -> String {
        var result: String = ""
        let categories = MWSys.sh.movieGenres
        if let categories = categories, categories.count > 0 {
            categories.forEach ({ (category) in
                if self.categoryIds.first == category.id {
                    result = category.name
                }
            })
        }

        return result
    }
}
