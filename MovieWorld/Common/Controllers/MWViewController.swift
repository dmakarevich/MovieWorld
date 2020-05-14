//
//  MWViewController.swift
//  MovieWorld
//
//  Created by Admin on 09.03.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class MWViewController: UIViewController {
    //MARK: - Variables
    var barTitle: String?
    var barImage: String = Constants.emptyString
    var fetchedMovie: MWDetailMovie?
    var movieId: Int?
    let dispatchGroup = DispatchGroup()

    //MARK: - Initialization
    func setup(title: String, imageName: String) {
        self.title = title
        self.barImage = imageName

        self.tabBarItem.title = self.barTitle
        self.tabBarItem.image = UIImage(named: self.barImage)

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: Constants.emptyString, style: .plain, target: nil, action: nil)
    }

    func createNavigationVC() -> UINavigationController {
        let recentVC = UINavigationController(rootViewController: self)
        recentVC.tabBarItem.title = self.title
        recentVC.tabBarItem.image = UIImage(named: self.barImage)

        return recentVC
    }

    //MARK: - Fetch movies
    func fetchMovie(movieId: Int) {
        let success: SuccessHandler = { [weak self] (response: MWDetailMovie) in
            guard let self = self else { return }

            debugPrint("~~~~~~~~~~~~~~~~~~~~~~~~~~~")
            debugPrint("title = \(response.title)")
            debugPrint("categories: ")
            response.categories.forEach({(category) in
                debugPrint(" - \(category.name)")
            })
            debugPrint("original title = \(response.originalTitle)")
            debugPrint("adult = \(response.adult)")
            debugPrint("description = \(response.description)")
            debugPrint("status = \(response.status)")
            debugPrint("original anguage = \(response.originalLanguage)")
            debugPrint("~~~~~~~~~~~~~~~~~~~~~~~~~~~")
            self.fetchedMovie = response
        }

        let url = ("\(URLPaths.movieById)\(movieId)")

        MWNet.sh.request(urlPath: url,
                         queryParameters: ["language": URLLanguage.by.urlValue],
                         of: MWDetailMovie.self,
                         successHandler: success)
    }
}
