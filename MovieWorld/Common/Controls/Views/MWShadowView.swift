//
//  MWShadowView.swift
//  MovieWorld
//
//  Created by Admin on 27.03.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class MWShadowView: UIView {

    public var shadowLayer: CAShapeLayer = CAShapeLayer()
    
    public var shadowWidth: CGFloat = 0.0
    public var shadowHeight: CGFloat = 4.0
    public var shadowRadius: CGFloat = 4.0
    
    public var shadowColor: UIColor? = .black
    public var shadowOpacity: Float = 0.05
            
    public var borderWidth: CGFloat = 0
    public var borderColor: UIColor? = .black
        
    
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
