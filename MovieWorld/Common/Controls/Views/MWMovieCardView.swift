//
//  MWMovieCardView.swift
//  MovieWorld
//
//  Created by Admin on 27.03.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class MWMovieCardView: MWShadowView {
    //MARK: - Variables      
    private lazy var coverImage: UIImageView = {
        let iv = UIImageView()
        iv.cornerRadius = 5
        iv.image = UIImage(named: Constants.Images.defaultMovie)

        return iv
    }()

    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = UIColor(named: Constants.Colors.textColor)
        label.text = "Title"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping

        return label
    }()

    private lazy var subtitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(named: Constants.Colors.textColor)
        label.text = "Year, Country"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping

        return label
    } ()

    private lazy var categories: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(named: Constants.Colors.textColor)?.withAlphaComponent(0.5)
        label.text = "Categories"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping

        return label
    } ()

    private var imageSize = CGSize(width: 70, height: 100)
    private let coverImageEdgeInsets = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 8)
    private let titleEdgeInsets = UIEdgeInsets(top: 10, left: 16, bottom: 3, right: 30)

    //MARK: - Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(self.coverImage)
        self.addSubview(self.title)
        self.addSubview(self.subtitle)
        self.addSubview(self.categories)

        self.makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Add Constraints
    func makeConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.coverImage.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().inset(self.coverImageEdgeInsets)
            make.size.equalTo(self.imageSize)
            make.bottom.lessThanOrEqualToSuperview().inset(self.coverImageEdgeInsets.bottom)
        }

        self.title.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(self.titleEdgeInsets.top)
            make.left.equalTo(self.coverImage.snp.right).offset(self.titleEdgeInsets.left)
            make.right.equalToSuperview().inset(self.titleEdgeInsets.right)
        }

        self.subtitle.snp.makeConstraints { (make) in
            make.top.equalTo(self.title.snp.bottom).offset(self.titleEdgeInsets.bottom)
            make.left.equalTo(self.coverImage.snp.right).offset(self.titleEdgeInsets.left)
            make.right.equalToSuperview().inset(self.titleEdgeInsets.right)
        }

        self.categories.snp.makeConstraints { (make) in
            make.top.equalTo(self.subtitle.snp.bottom)
            make.left.equalTo(self.coverImage.snp.right).offset(self.titleEdgeInsets.left)
            make.right.equalToSuperview().inset(self.titleEdgeInsets.right)
            make.bottom.lessThanOrEqualToSuperview().inset(self.coverImageEdgeInsets.bottom)
        }
    }

    func setData(movie: MWMovie) {
        self.title.text = movie.title
        self.subtitle.text = movie.getSubtitle()
        self.categories.text = movie.getCategoryString()
        var image: UIImage?
        if let imagedata = movie.image, let img = UIImage(data: imagedata) {
            image = img
        } else {
            image = UIImage(named: Constants.Images.defaultMovie)
        }
        self.coverImage.image = image
    }
}
