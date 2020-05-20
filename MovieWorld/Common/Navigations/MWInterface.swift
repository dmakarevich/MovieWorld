//
//  MWInterface.swift
//  MovieWorld
//
//  Created by Admin on 21.02.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

typealias MWI = MWInterface

class MWInterface {
    static let sh = MWInterface()

    weak var window: UIWindow?
    private lazy var tabBarController = MWMainTabBarController()

    func setup(window: UIWindow) {
        self.window = window
        self.setUpNavigationBarStyle()
        MWSys.sh.setup()

        window.rootViewController = self.tabBarController
        window.makeKeyAndVisible()
    }

    private init() {}

    private func setUpNavigationBarStyle() {
        let standartNavBar = UINavigationBar.appearance()
        standartNavBar.backgroundColor = .white
        standartNavBar.tintColor = UIColor(named: Constants.Colors.accentColor)
        standartNavBar.prefersLargeTitles = true

        let newNavBar = UINavigationBarAppearance()
        newNavBar.configureWithDefaultBackground()

        standartNavBar.scrollEdgeAppearance = newNavBar
    }

    func push(vc: UIViewController) {
        guard let navigationController = self.tabBarController.selectedViewController as? UINavigationController else { return }
        navigationController.pushViewController(vc, animated: true)
    }

    func popVC() {
        guard let navigationController = self.tabBarController.selectedViewController as? UINavigationController else { return }
        navigationController.popViewController(animated: true)
    }
}
