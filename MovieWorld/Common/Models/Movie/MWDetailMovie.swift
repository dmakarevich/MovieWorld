//
//  MWDetailMovie.swift
//  MovieWorld
//
//  Created by Admin on 29.04.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

class MWDetailMovie: MWMovie {
    //MARK: - Enums
    enum CodingKeys: String, CodingKey {
        case categories = "genres"
        case productionCountries = "production_countries"
        case imdbId = "imdb_id"
        case status
        case runtime
    }

    //MARK: - Variables
    let categories: [MWCategory]
    let productionCountries: [MWCountry]
    let status: String
    let imdbId: String
    let runtime: Int

    //MARK: - Initialization
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.categories = (try? container.decode([MWCategory].self, forKey: .categories)) ?? []
        self.productionCountries = (try? container.decode([MWCountry].self, forKey: .productionCountries)) ?? []
        self.status = (try? container.decode(String.self, forKey: .status)) ?? ""
        self.imdbId = (try? container.decode(String.self, forKey: .imdbId)) ?? ""
        self.runtime = (try? container.decode(Int.self, forKey: .runtime)) ?? 0

        try super.init(from: decoder)
    }

    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(self.categories, forKey: .categories)
        try container.encode(self.productionCountries, forKey: .productionCountries)
        try container.encode(self.status, forKey: .status)
        try container.encode(self.imdbId, forKey: .imdbId)
        try container.encode(self.runtime, forKey: .runtime)

        try super.encode(to: encoder)
    }

    //MARK: - get production country names as string
    func getProductionCountriesString() -> String {
        var result: String = ""
        self.productionCountries.forEach({ (country) in
            result += Constants.commaDelimiter + country.name
        })

        return result
    }

    override func getCategoryString() -> String {
        var result = ""
        self.categories.forEach({ (category) in
            result += self.categories.first?.id != category.id ? Constants.commaDelimiter : ""
            result += category.name
        })

        return result
    }

    override func getSubtitle() -> String {
        var result = ""
        if let year = self.getReleaseYear() {
            result += year
        }
        result += self.getProductionCountriesString()

        return result
    }

    func getRuntime() -> String {
        return "  " + String(self.runtime) + Constants.runtime
    }
}
