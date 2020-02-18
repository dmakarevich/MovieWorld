//
//  ViewController.swift
//  MovieWorld
//
//  Created by Admin on 16.02.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    // MARK: - Variables
    
    private var movieCard2 = MWCardView()
    private var movieCard = UIView()
    private var titleLabel: UILabel = UILabel()
    private var subtitleLabel: UILabel = UILabel()
    private var genreLabel: UILabel = UILabel()
    private var markLabel: UILabel = UILabel()
    private var imageView: MWRoundImageView = MWRoundImageView()
    
    private let imageViewEdgeInsets = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
    private let titleEdgeInsets = UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 0)
    private let subtitleEdgeInsets = UIEdgeInsets(top: 4, left: 16, bottom: 0, right: 0)
    private let genreEdgeInsets = UIEdgeInsets(top: 4, left: 16, bottom: 0, right: 0)
    private let markEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 10, right: 0)
    
    private var cardSize = CGSize(width: 375, height: 130)
    private var imageSize = CGSize(width: 75, height: 110)
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.movieCard)
        self.movieCard.backgroundColor = .white
        
        self.movieCard.addSubview(self.imageView)
        self.movieCard.addSubview(self.titleLabel)
        self.movieCard.addSubview(self.subtitleLabel)
        self.movieCard.addSubview(self.genreLabel)
        self.movieCard.addSubview(self.markLabel)
        
        self.initLabels()
        self.addContraintsToMovieCardWithSnapKit()
    }
    
    // MARK: - Add constraints
       
    func addContraintsToMovieCardWithSnapKit() {
        self.movieCard.snp.makeConstraints{ (make) -> Void in
            make.size.equalTo(self.cardSize)
            make.center.equalToSuperview()
        }
       
        self.imageView.snp.makeConstraints { (make) -> Void in
            make.top.left.bottom.equalTo(self.movieCard)
                            .inset(self.imageViewEdgeInsets)
            make.size.equalTo(imageSize)
        }
        
        self.titleLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.movieCard.snp.top)
                            .inset(self.titleEdgeInsets.top)
            make.left.equalTo(self.imageView.snp.right)
                            .offset(self.imageViewEdgeInsets.right)
        }
           
        self.subtitleLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.titleLabel.snp.bottom)
                            .offset(self.subtitleEdgeInsets.top)
            make.left.equalTo(self.imageView.snp.right)
                            .offset(self.subtitleEdgeInsets.left)
        }
           
        self.genreLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.subtitleLabel.snp.bottom)
                            .offset(self.genreEdgeInsets.top)
            make.left.equalTo(self.imageView.snp.right)
                            .offset(self.genreEdgeInsets.left)
        }
        
        self.markLabel.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.movieCard.snp.bottom)
                            .inset(self.markEdgeInsets.bottom)
            make.left.equalTo(self.imageView.snp.right)
                            .offset(self.markEdgeInsets.left)
        }
    }
    
    // MARK: - Initialization
    
    func initLabels() {
        self.imageView.backgroundColor = .magenta
        self.imageView.cornerRadius = 5
        
        self.titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        self.titleLabel.text = "Green Book"
        
        self.subtitleLabel.font = UIFont.systemFont(ofSize: 13)
        self.subtitleLabel.text = "2017, USA"
                
        self.genreLabel.font = UIFont.systemFont(ofSize: 13)
        self.genreLabel.textColor = .gray
        self.genreLabel.text = "Comedy, Drama, Foreign"
        
        self.markLabel.font = UIFont.systemFont(ofSize: 13)
        self.markLabel.text = "KP 8.3, IMDB 8.2"
    }
}
