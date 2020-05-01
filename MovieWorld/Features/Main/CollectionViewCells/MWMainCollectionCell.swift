//
//  MWMainCardCell.swift
//  MovieWorld
//
//  Created by Admin on 18.03.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class MWMainCollectionCell: UICollectionViewCell {    
    //MARK: - Variables
    static var cellReuseIdentifier: String {
        return "MainCardCell"
    }
    
    var movieId: Int?
    
    private let imageSize = CGSize(width: 130, height: 185)
    private let coverImageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0)
    private let titleEdgeInsets = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
    
    //MARK: - Gui variables
    var coverImage: UIImageView = {
        let iv = UIImageView()
        iv.cornerRadius = 5
        iv.image = UIImage(named: "defaultCard")
        
        return iv
    }()
    
    var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.FontSize.size17, weight: .bold)
        label.textColor = .black
        label.text = "21 Bridges"
        
        return label
    }()
    
    var subtitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.FontSize.size13)
        label.textColor = .black
        label.text = "2019, Drama"
        
        return label
    }()
    
    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.coverImage)
        self.addSubview(self.title)
        self.addSubview(self.subtitle)
        
        self.makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Constraints
    func makeConstraints() {
        self.snp.updateConstraints { (make) in
            make.width.equalTo(self.imageSize.width)
        }
        
        self.coverImage.snp.makeConstraints { (make) in
            make.top.left.equalTo(self.contentView)
                .inset(self.coverImageEdgeInsets)
            make.size.equalTo(self.imageSize)
        }
        
        self.title.snp.makeConstraints { (make) in
            make.top.equalTo(self.coverImage.snp.bottom)
                .offset(self.titleEdgeInsets.top)
            make.left.equalToSuperview()
                .offset(self.titleEdgeInsets.left)
        }
        
        self.subtitle.snp.makeConstraints { (make) in
            make.top.equalTo(self.title.snp.bottom).inset(0)
            make.left.equalToSuperview().offset(0)
        }
    }
}
