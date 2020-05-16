//
//  MWMainTabBarController.swift
//  MovieWorld
//
//  Created by Admin on 09.03.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class MWMainTabBarController: UITabBarController {
    //MARK: - Initialization
    private func setTabBarAppearence() {
        self.tabBar.barTintColor = .white
        self.tabBar.tintColor = UIColor(named: Constants.Colors.accentColor)
    }

    //MARK: - View life cycle
    override func viewDidLoad() {
        let mainVC = MWMainViewController()
        mainVC.setup(title: Constants.BarTitle.main,
                     imageName: Constants.BarIcon.main)
        let categoryVC = MWCategoryController()
        categoryVC.setup(title: Constants.BarTitle.category,
                         imageName: Constants.BarIcon.category)
        let searchVC = MWSearchController()
        searchVC.setup(title: Constants.BarTitle.search,
                       imageName: Constants.BarIcon.search)

        let tabBarList = [mainVC,
                          categoryVC,
                          searchVC]

        self.viewControllers = tabBarList
            .map { self.createNavigationVC(viewController: $0) }
        self.setTabBarAppearence()
    }

    func createNavigationVC(viewController vc: MWViewController) -> UINavigationController {
        let recentVC = UINavigationController(rootViewController: vc)
        recentVC.tabBarItem.title = vc.title
        recentVC.tabBarItem.image = UIImage(named: vc.barImage)

        return recentVC
    }
}
