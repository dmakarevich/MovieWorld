//
//  MWMainTabBarController.swift
//  MovieWorld
//
//  Created by Admin on 09.03.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit


class MWMainTabBarController: UITabBarController {
    let mainVC = MWMainViewController()
    let categoryVC = MWCategoryController()
    let searchVC = MWSearchController()
    
    
    override func viewDidLoad() {
        self.mainVC.setup(title: "Main", imageName: "mainBarIcon")
        self.categoryVC.setup(title: "Category", imageName: "categoryBarIcon")
        self.searchVC.setup(title: "Search", imageName: "searchBarIcon")
        
        let tabBarList = [mainVC.createNavigationVC(),
                          categoryVC.createNavigationVC(),
                          searchVC.createNavigationVC()]

        self.viewControllers = tabBarList
        
        self.setTabBarAppearence()
    }
    
    private func setTabBarAppearence() {
        self.tabBar.barTintColor = .white
        self.tabBar.tintColor = UIColor(named: "accentColor")
    }
}
