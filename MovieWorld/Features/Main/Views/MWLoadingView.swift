//
//  MWLoadingView.swift
//  MovieWorld
//
//  Created by Admin on 18.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SnapKit

class MWLoadingView: UIView {
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.backgroundColor = .white
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.color = UIColor(named: Constants.Colors.accentColor)

        return activityIndicator
    } ()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(self.activityIndicator)
        self.activityIndicator.snp.makeConstraints({ (make) in
            make.center.equalToSuperview()
        })
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func start() {
        self.activityIndicator.startAnimating()
    }

    func stop() {
        self.activityIndicator.stopAnimating()
    }
}
