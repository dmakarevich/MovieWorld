//
//  MWFilterCategoriesCollectionViewCell.swift
//  MovieWorld
//
//  Created by Admin on 30.03.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class MWFilterCategoriesCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Variables
    
    var filterLabel: UILabel = UILabel()
    
    class var cellReuseIdentifier: String {
        return "FilterCategoriesCollectionViewCell"
    }
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.cornerRadius = 5
        self.backgroundColor = UIColor(named: "accentColor")?.withAlphaComponent(0.5)
                
        self.initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialize() {
        self.filterLabel.font = UIFont.systemFont(ofSize: 13)
        self.filterLabel.textColor = .white
        self.filterLabel.text = "Category"
        
        self.addSubview(self.filterLabel)
          
        self.makeConstraints()
    }
    
    //MARK: - Add Constraints
       
     func makeConstraints() {
        self.filterLabel.snp.updateConstraints { (make) in
            //make.centerY.equalTo(self.snp.centerY)
            make.center.equalToSuperview()
         }
    }
}
