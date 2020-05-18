//
//  MWEx+View.swift
//  MovieWorld
//
//  Created by Admin on 20.03.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

extension UIView {
    //MARK: - Variables
    var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            return self.layer.cornerRadius = newValue
        }
    }
}
