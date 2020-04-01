//
//  MWMovieCardView.swift
//  MovieWorld
//
//  Created by Admin on 27.03.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class MWMovieCardView: UIView {
      
    //MARK: - Variables
      
    var coverImage: UIImageView = UIImageView()
    var title: UILabel = UILabel()
    var subtitle: UILabel = UILabel()
    var categories: UILabel = UILabel()
      
    private var imageSize = CGSize(width: 70, height: 100)
      
    private let coverImageEdgeInsets = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 8)
    private let titleEdgeInsets = UIEdgeInsets(top: 10, left: 16, bottom: 3, right: 70)
      
    //MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.coverImage)
        self.addSubview(self.title)
        self.addSubview(self.subtitle)
        self.addSubview(self.categories)
        
        self.initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialize() {
        self.backgroundColor = .white
          
        self.coverImage.cornerRadius = 5
        self.coverImage.image = UIImage(named: "defaultCard")
          
        self.title.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        self.title.textColor = UIColor(named: "textColor")
        self.title.text = "21 Bridges"
        self.title.numberOfLines = 0
        self.title.lineBreakMode = .byWordWrapping
          
        self.subtitle.font = UIFont.systemFont(ofSize: 13)
        self.subtitle.textColor = .black
        self.subtitle.text = "2019, USA"
        self.subtitle.numberOfLines = 0
        self.subtitle.lineBreakMode = .byWordWrapping
          
        self.categories.font = UIFont.systemFont(ofSize: 13)
        self.categories.textColor = UIColor(named: "textColor")?.withAlphaComponent(0.5)
        self.categories.text = "Drama, Crime, Foreign"
        self.categories.numberOfLines = 0
        self.categories.lineBreakMode = .byWordWrapping
          
        self.makeConstraints()
    }
      
    //MARK: - Add Constraints
      
    func makeConstraints() {
        self.coverImage.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview().inset(self.coverImageEdgeInsets)
            make.size.equalTo(self.imageSize)
        }
          
        self.title.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(self.titleEdgeInsets.top)
            make.left.equalTo(self.coverImage.snp.right).offset(self.titleEdgeInsets.left)
            make.right.equalToSuperview().offset(self.titleEdgeInsets.right)
        }

        self.subtitle.snp.makeConstraints { (make) in
            make.top.equalTo(self.title.snp.bottom).offset(self.titleEdgeInsets.bottom)
            make.left.equalTo(self.coverImage.snp.right).offset(self.titleEdgeInsets.left)
            make.right.equalToSuperview().offset(self.titleEdgeInsets.right)
        }

        self.categories.snp.makeConstraints { (make) in
            make.top.equalTo(self.subtitle.snp.bottom)
            make.left.equalTo(self.coverImage.snp.right).offset(self.titleEdgeInsets.left)
            make.right.equalToSuperview().offset(self.titleEdgeInsets.right)
        }
    }
}
