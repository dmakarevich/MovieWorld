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
    
    class var cellReuseIdentifier: String {
        return "FilterCategoriesCollectionViewCell"
    }
    
    lazy var filterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .white
        label.text = "Category"
        
        return label
    }()
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.filterLabel)                
        self.setupData()
        self.makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData() {
        self.cornerRadius = 5
        self.backgroundColor = UIColor(named: "accentColor")?.withAlphaComponent(0.5)
    }
    
    //MARK: - Add Constraints
       
     func makeConstraints() {
        self.filterLabel.snp.updateConstraints { (make) in
            make.center.equalToSuperview()
         }
    }
}
