//
//  MWViewController.swift
//  MovieWorld
//
//  Created by Admin on 09.03.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class MWViewController: UIViewController {
    
    var barTitle: String?
    var barImage: String = ""
    
    func setup(title: String, imageName: String) {
        self.title = title
        self.barImage = imageName
        
        self.tabBarItem.title = self.barTitle
        self.tabBarItem.image = UIImage(named: self.barImage)
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
  
    func createNavigationVC() -> UINavigationController {
        let recentVC = UINavigationController(rootViewController: self)
        recentVC.tabBarItem.title = self.title
        recentVC.tabBarItem.image = UIImage(named: self.barImage)
        
        return recentVC
    }
    
}
