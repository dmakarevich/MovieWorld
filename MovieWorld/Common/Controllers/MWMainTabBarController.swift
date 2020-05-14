//
//  MWMainTabBarController.swift
//  MovieWorld
//
//  Created by Admin on 09.03.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class MWMainTabBarController: UITabBarController {
    //MARK: - Variables
    let mainVC = MWMainViewController()
    let categoryVC = MWCategoryController()
    let searchVC = MWSearchController()

    //MARK: - Initialization
    private func setTabBarAppearence() {
        self.tabBar.barTintColor = .white
        self.tabBar.tintColor = UIColor(named: Constants.Colors.accentColor)
    }

    //MARK: - View life cycle
    override func viewDidLoad() {
        self.mainVC.setup(title: Constants.BarTitle.main, imageName: Constants.BarIcon.main)
        self.categoryVC.setup(title: Constants.BarTitle.category, imageName: Constants.BarIcon.category)
        self.searchVC.setup(title: Constants.BarTitle.search, imageName: Constants.BarIcon.search)

        let tabBarList = [self.mainVC.createNavigationVC(),
                          self.categoryVC.createNavigationVC(),
                          self.searchVC.createNavigationVC()]

        self.viewControllers = tabBarList
        self.setTabBarAppearence()
    }
}
