//
//  MWSystem.swift
//  MovieWorld
//
//  Created by Admin on 13.04.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation

typealias MWSys = MWSystem

class MWSystem {
    static let sh = MWSystem()

    private(set) var configuration: MWConfiguration?
    private(set) var movieGenres: [MWCategory]? {
        didSet {
            NotificationCenter.default.post(name: Constants.NCNames.categories,
                                            object: nil)
        }
        willSet {
            NotificationCenter.default.removeObserver(self,
                                                      name: Constants.NCNames.categories,
                                                      object: nil)
        }
    }

    private init() {}

    func setup() {
        self.fetchConfiguration()
        self.fetchCategories()
    }

    func fetchConfiguration() {
        let succcess: SuccessHandler = { (response: MWResponseConfiguration) in
            MWSys.sh.configuration = response.images
            debugPrint("~~ fetchConfiguration Compete!!")
        }

        let url = "/configuration"
        MWNet.sh.request(urlPath: url, of: MWResponseConfiguration.self, successHandler: succcess)
    }

    func fetchCategories() {
        let success: SuccessHandler = { (categoryResponse: MWResponseCategory) in
            let categories: [MWCategory] = categoryResponse.genres

            MWSystem.sh.movieGenres = categories
        }

        MWNet.sh.request(urlPath: URLPaths.genreList,
                         queryParameters: ["language": URLLanguage.by.urlValue],
                         of: MWResponseCategory.self,
                         successHandler: success)
    }
}
