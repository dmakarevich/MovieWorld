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
    static var language: URLLanguage = .en

    private(set) var configuration: MWConfiguration?
    private(set) var movieGenres: [MWCategory]? {
        didSet {
            NotificationCenter
                .default
                .post(name: Constants.NCNames.categories,
                      object: nil)
        }
        willSet {
            NotificationCenter
                .default
                .removeObserver(self,
                                name: Constants.NCNames.categories,
                                object: nil)
        }
    }

    private init() {}

    func setup() {
        self.fetchConfiguration()
        self.fetchCategories()
    }

    private func fetchConfiguration() {
        let succcess: SuccessHandler = { (response: MWResponseConfiguration) in
            MWSys.sh.configuration = response.images
        }

        let errors = { (error: MWNetError) in
            print(error)
        }

        MWNet.sh.requestAlamofire(url: URLPaths.confiurations,
                                  successHandler: succcess,
                                  errorHandler: errors)
    }

    private func fetchCategories() {
        let success: SuccessHandler = { (categoryResponse: MWResponseCategory) in
            let categories: [MWCategory] = categoryResponse.genres

            MWSystem.sh.movieGenres = categories
        }

        let errors = { (error: MWNetError) in
            print(error)
        }

        MWNet.sh.requestAlamofire(url: URLPaths.genreList,
                                  successHandler: success,
                                  errorHandler: errors)
    }
}
