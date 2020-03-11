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
    
    private var movieCard: UIView = UIView()
    private var secondMovieCard: UIView = UIView()
    
    private var titleLabel: UILabel = UILabel()
    private var subtitleLabel: UILabel = UILabel()
    private var genreLabel: UILabel = UILabel()
    private var markLabel: UILabel = UILabel()
    private var imageView: MWRoundImageView = MWRoundImageView()
    
    private var secondTitleLabel: UILabel = UILabel()
    private var secondSubtitleLabel: UILabel = UILabel()
    private var secondGenreLabel: UILabel = UILabel()
    private var secondMarkLabel: UILabel = UILabel()
    private var secondImageView: MWRoundImageView = MWRoundImageView()
    
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
        self.movieCard.addSubview(self.imageView)
        self.movieCard.addSubview(self.titleLabel)
        self.movieCard.addSubview(self.subtitleLabel)
        self.movieCard.addSubview(self.genreLabel)
        self.movieCard.addSubview(self.markLabel)
        
        self.initLabels()
        self.addContraintsToMovieCardWithSnapKit()
        
        self.view.addSubview(self.secondMovieCard)
        self.secondMovieCard.addSubview(self.secondImageView)
        self.secondMovieCard.addSubview(self.secondTitleLabel)
        self.secondMovieCard.addSubview(self.secondSubtitleLabel)
        self.secondMovieCard.addSubview(self.secondGenreLabel)
        self.secondMovieCard.addSubview(self.secondMarkLabel)

        self.initSecondLabels()
        self.addContraintsToMovieCardWithAnchors()
    }
    
    // MARK: - Add constraints with Anchor
    
    func addContraintsToMovieCardWithAnchors() {
        
        self.addMovieCardConstraints()
        self.addImageConstraints()
        self.addTitleConstraints()
        self.addSubtitleConstraints()
        self.addGenreConstraints()
        self.addMarkConstraints()
    }
    
    func addMovieCardConstraints() {
        self.secondMovieCard.translatesAutoresizingMaskIntoConstraints = false
        
        let secondMovieCardConstraints = [
            self.secondMovieCard.topAnchor.constraint(equalTo: self.movieCard.bottomAnchor, constant: 20),
            self.secondMovieCard.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.secondMovieCard.widthAnchor.constraint(equalToConstant: self.cardSize.width),
            self.secondMovieCard.heightAnchor.constraint(equalToConstant: self.cardSize.height)
        ]
        
        NSLayoutConstraint.activate(secondMovieCardConstraints)
    }
    
    func addImageConstraints() {
        self.secondImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let secondImageViewConstraints = [
            self.secondImageView.topAnchor.constraint(equalTo: self.secondMovieCard.topAnchor,
                                                constant: self.imageViewEdgeInsets.top),
            self.secondImageView.leftAnchor.constraint(equalTo: self.secondMovieCard.leftAnchor,
                                                 constant: self.imageViewEdgeInsets.left),
            self.secondImageView.bottomAnchor.constraint(equalTo: self.secondMovieCard.bottomAnchor,
                                                   constant: (self.imageViewEdgeInsets.bottom * -1)),
            self.secondImageView.widthAnchor.constraint(equalToConstant: self.imageSize.width)
        ]
        
        NSLayoutConstraint.activate(secondImageViewConstraints)
    }
    
    func addTitleConstraints() {
        self.secondTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let secondTitleConstraints = [
            self.secondTitleLabel.topAnchor.constraint(equalTo: self.secondMovieCard.topAnchor,
                                                 constant: self.titleEdgeInsets.top),
            self.secondTitleLabel.leadingAnchor.constraint(equalTo: self.secondImageView.trailingAnchor,
                                                     constant: self.titleEdgeInsets.left)
        ]
        
        NSLayoutConstraint.activate(secondTitleConstraints)
    }
    
    func addSubtitleConstraints() {
        self.secondSubtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let secondSubtitleConstraints = [
            self.secondSubtitleLabel.topAnchor.constraint(equalTo: self.secondTitleLabel.bottomAnchor,
                                                 constant: self.subtitleEdgeInsets.top),
            self.secondSubtitleLabel.leadingAnchor.constraint(equalTo: self.secondImageView.trailingAnchor,
                                                     constant: self.subtitleEdgeInsets.left)
        ]
        
        NSLayoutConstraint.activate(secondSubtitleConstraints)
    }
    
    func addGenreConstraints() {
        self.secondGenreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let secondGenreConstraints = [
            self.secondGenreLabel.topAnchor.constraint(equalTo: self.secondSubtitleLabel.bottomAnchor,
                                                 constant: self.genreEdgeInsets.top),
            self.secondGenreLabel.leadingAnchor.constraint(equalTo: self.secondImageView.trailingAnchor,
                                                     constant: self.genreEdgeInsets.left)
        ]
        
        NSLayoutConstraint.activate(secondGenreConstraints)
    }
    
    func addMarkConstraints() {
        self.secondMarkLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let secondMarkConstraints = [
            self.secondMarkLabel.bottomAnchor.constraint(equalTo: self.secondMovieCard.bottomAnchor,
                                                   constant: self.markEdgeInsets.bottom * -1),
            self.secondMarkLabel.leadingAnchor.constraint(equalTo: self.secondImageView.trailingAnchor,
                                                    constant: self.markEdgeInsets.left)
        ]
        
        NSLayoutConstraint.activate(secondMarkConstraints)
    }

// MARK: - Add constraints with SnapKit
    
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
        self.movieCard.backgroundColor = .white
        
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
    
    func initSecondLabels() {
        self.secondMovieCard.backgroundColor = .white
        
        self.secondImageView.backgroundColor = .magenta
        self.secondImageView.cornerRadius = 5
        
        self.secondTitleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        self.secondTitleLabel.text = "Ruby Book"
        
        self.secondSubtitleLabel.font = UIFont.systemFont(ofSize: 13)
        self.secondSubtitleLabel.text = "2018, USA"
                
        self.secondGenreLabel.font = UIFont.systemFont(ofSize: 13)
        self.secondGenreLabel.textColor = .gray
        self.secondGenreLabel.text = "Comedy, Drama, Foreign"
        
        self.secondMarkLabel.font = UIFont.systemFont(ofSize: 13)
        self.secondMarkLabel.text = "KP 7.3, IMDB 7.2"
    }
}
