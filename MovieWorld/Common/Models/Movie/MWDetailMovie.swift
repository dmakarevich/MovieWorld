//
//  MWDetailMovie.swift
//  MovieWorld
//
//  Created by Admin on 29.04.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation


class MWDetailMovie: MWMovie {

    enum CodingKeys: String, CodingKey {
        case categories = "genres"
        case productionCountries = "production_countries"
        case imdbId = "imdb_id"
        case status
    }
    
    let categories: [MWCategory]
    let productionCountries: [MWCountry]
    let status: String
    let imdbId: String
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.categories = (try? container.decode([MWCategory].self, forKey: .categories)) ?? []
        self.productionCountries = (try? container.decode([MWCountry].self, forKey: .productionCountries)) ?? []
        self.status = (try? container.decode(String.self, forKey: .status)) ?? Constants.emptyString
        self.imdbId = (try? container.decode(String.self, forKey: .imdbId)) ?? Constants.emptyString
        
        try super.init(from: decoder)
    }
        
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(self.categories, forKey: .categories)
        try container.encode(self.productionCountries, forKey: .productionCountries)
        try container.encode(self.status, forKey: .status)
        try container.encode(self.imdbId, forKey: .imdbId)
        
        try super.encode(to: encoder)
    }

    //MARK: - get production country names as string
    func getProductionCountriesString() -> String {
        var result: String = Constants.emptyString
        self.productionCountries.forEach({ (country) in
            result += Constants.commaDelimiter + country.name
        })
        
        return result
    }

}
