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
    static var cellReuseIdentifier: String = "MWMainCollectionCell"

    var movieId: Int?

    private let imageSize = CGSize(width: 130, height: 185)
    private let coverImageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0)
    private let titleEdgeInsets = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)

    //MARK: - Gui variables
    private var coverImage: UIImageView = {
        let iv = UIImageView()
        iv.cornerRadius = 5
        iv.image = UIImage(named: Constants.Images.defaultMovie)

        return iv
    }()

    private var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.FontSize.size17, weight: .bold)
        label.textColor = UIColor.init(named: Constants.Colors.textColor)
        label.text = "Title"

        return label
    }()

    private var subtitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.FontSize.size13)
        label.textColor = .black
        label.text = "Year, Category"

        return label
    }()

    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.contentView.addSubview(self.coverImage)
        self.contentView.addSubview(self.title)
        self.contentView.addSubview(self.subtitle)

        self.updateConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Constraints
    override func updateConstraints() {
        self.coverImage.snp.updateConstraints { (make) in
            make.top.left.right.equalToSuperview().inset(self.coverImageEdgeInsets)
            make.size.equalTo(self.imageSize)
        }

        self.title.snp.makeConstraints { (make) in
            make.top.equalTo(self.coverImage.snp.bottom)
                .offset(self.titleEdgeInsets.top)
            make.left.right.equalToSuperview()
                .offset(self.titleEdgeInsets.left)
        }

        self.subtitle.snp.makeConstraints { (make) in
            make.top.equalTo(self.title.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview()//.offset(5)
        }

        super.updateConstraints()
    }

    func set(movie: MWMovie) {
        if let data = movie.image, let image = UIImage(data: data) {
            self.coverImage.image = image
        } else {
            self.coverImage.image = UIImage(named: Constants.Images.defaultMovie)
        }
        self.title.text = movie.title
        self.subtitle.text = movie.getSubtitle()
        self.movieId = movie.id

        self.setNeedsUpdateConstraints()
    }
}
