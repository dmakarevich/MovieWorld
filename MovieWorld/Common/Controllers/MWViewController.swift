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

    //MARK: - Initialization
    func setup(title: String, imageName: String) {
        self.title = title
        self.barImage = imageName

        self.tabBarItem.title = self.barTitle
        self.tabBarItem.image = UIImage(named: self.barImage)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: Constants.emptyString, style: .plain, target: nil, action: nil)
    }

    func enableLargeTitle() {
        let navBar = self.navigationController?.navigationBar
        navBar?.prefersLargeTitles = true
    }

    func disableLargeTitle() {
        let navBar = self.navigationController?.navigationBar
        navBar?.prefersLargeTitles = false
    }
}
