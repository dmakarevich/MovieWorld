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
        
    var configuration: MWConfiguration?
    var movieGenres: [MWCategory]? {
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
    
    private init() {
        MWNet.sh.fetchConfiguration()
        self.fetchCategories()
    }
    
    func fetchCategories() {
        let success: SuccessHandler = { (categoryResponse: MWResponseCategory) in
            let categories: [MWCategory] = categoryResponse.genres
                        
            MWSystem.sh.movieGenres = categories
        }
        
        MWNet.sh.request(URLPaths.genreList,
                         ["language": URLLanquage.by.urlValue],
                         of: MWResponseCategory.self,
                         successHandler: success)
    }
}
