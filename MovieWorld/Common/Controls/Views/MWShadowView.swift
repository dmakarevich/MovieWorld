//
//  MWShadowView.swift
//  MovieWorld
//
//  Created by Admin on 27.03.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class MWShadowView: UIView {
    var shadowLayer: CAShapeLayer = CAShapeLayer()

    var shadowWidth: CGFloat = 0.0
    var shadowHeight: CGFloat = 4.0
    var shadowRadius: CGFloat = 4.0

    var shadowColor: UIColor? = .black
    var shadowOpacity: Float = 0.05

    var borderWidth: CGFloat = 0
    var borderColor: UIColor? = .black

    override func layoutSubviews() {
        super.layoutSubviews()

        self.shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: self.cornerRadius).cgPath
        self.shadowLayer.fillColor = UIColor.white.cgColor

        self.shadowLayer.shadowColor = self.shadowColor?.cgColor
        self.shadowLayer.shadowPath = self.shadowLayer.path
        self.shadowLayer.shadowOffset = CGSize(width: self.shadowWidth, height: self.shadowHeight)
        self.shadowLayer.shadowOpacity = self.shadowOpacity
        self.shadowLayer.shadowRadius = self.shadowRadius

        self.layer.insertSublayer(shadowLayer, at: 0)
        self.layer.borderWidth = self.borderWidth
        self.layer.borderColor = self.borderColor?.cgColor
    }
}
