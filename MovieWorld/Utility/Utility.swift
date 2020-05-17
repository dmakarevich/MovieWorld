//
//  Utility.swift
//  MovieWorld
//
//  Created by Admin on 30.04.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

struct Utility {
    static func stringToDate(dateString: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        return formatter.date(from: dateString) ?? Date()
    }

    static func showActivityIndicator(view: UIView, targetVC: UIViewController = MWViewController()) {
        let activityIndicator = UIActivityIndicatorView()

        activityIndicator.backgroundColor = .white
        activityIndicator.center = view.center//targetVC.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.tag = 1
        activityIndicator.color = UIColor(named: Constants.Colors.accentColor)
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }

    static func hideActivityIndicator(view: UIView) {
        let activityIndicator = view.viewWithTag(1) as? UIActivityIndicatorView
        activityIndicator?.stopAnimating()
    }
}
