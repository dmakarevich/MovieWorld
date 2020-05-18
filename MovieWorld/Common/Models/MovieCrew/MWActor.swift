//
//  MWActor.swift
//  MovieWorld
//
//  Created by Admin on 17.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

class MWActor: Codable {
    enum CodingKeys: String, CodingKey {
        case id, name, gender, birthday, deathday, biography
        case placeOfBirth = "place_of_birth"
        case poster = "profile_path"
    }

    let id: Int
    let name: String
    let gender: Int
    let birthday: Date?
    let deathday: Date?
    let biography: String
    let placeOfBirth: String
    let poster: String
    var image: Data? = nil

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.id = (try? container.decode(Int.self, forKey: .id)) ?? 0
        self.name = (try? container.decode(String.self, forKey: .name)) ?? ""
        self.gender = (try? container.decode(Int.self, forKey: .gender)) ?? 0
        let bday = (try? container.decode(String.self, forKey: .birthday)) ?? ""
        self.birthday = Utility.stringToDate(dateString: bday)
        let dday = (try? container.decode(String.self, forKey: .deathday)) ?? ""
        self.deathday = Utility.stringToDate(dateString: dday)
        self.biography = (try? container.decode(String.self, forKey: .biography)) ?? ""
        self.placeOfBirth = (try? container.decode(String.self, forKey: .placeOfBirth)) ?? ""
        self.poster = (try? container.decode(String.self, forKey: .poster)) ?? ""
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(self.id, forKey: .id)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.gender, forKey: .gender)
        try container.encode(self.birthday, forKey: .birthday)
        try container.encode(self.deathday, forKey: .deathday)
        try container.encode(self.biography, forKey: .biography)
        try container.encode(self.placeOfBirth, forKey: .placeOfBirth)
        try container.encode(self.poster, forKey: .poster)
    }

    func getAgeInYears() -> String {
        var years = ""
        var toDate = Date()
        if let deathday = self.deathday {
            toDate = deathday
        }
        if let birthday = self.birthday {
            let age = Calendar.current.dateComponents([.year],
                                                      from: birthday,
                                                      to: toDate).year
            if let age = age {
                years = "(" + String(age) + Constants.yearsOld + ")"
            }
        }

        return years
    }

    func getStringBirthday() -> String {
        var result: String = ""
        if let birthday = self.birthday,
            let day = Calendar.current.dateComponents([.day], from: birthday).day,
            let month = Calendar.current.dateComponents([.month], from: birthday).month,
            let year = Calendar.current.dateComponents([.year], from: birthday).year {
            result = String(day) + Constants.point + String(month) + Constants.point + String(year)
        }

        return result
    }

    func getBirdayAndYears() -> String {
        return self.getAgeInYears().isEmpty ? "" : self.getStringBirthday() + Constants.toDate + self.getAgeInYears()
    }
}
