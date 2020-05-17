//
//  MWCastCollectionViewCell.swift
//  MovieWorld
//
//  Created by Admin on 16.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class MWCastCollectionViewCell: UICollectionViewCell {
    //MARK: - Variables
    static var cellReuseIdentifier: String = "MWCastCollectionViewCell"

    private let imageSize = CGSize(width: 72, height: 92)
    private let coverImageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0)
    private let titleEdgeInsets = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)

    //MARK: - Gui variables
    private var coverImage: UIImageView = {
        let iv = UIImageView()
        iv.cornerRadius = 5
        iv.image = UIImage(named: Constants.Images.defaultPerson)

        return iv
    }()

    private var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.FontSize.size17, weight: .bold)
        label.textColor = UIColor.init(named: Constants.Colors.textColor)
        label.text = "Name"

        return label
    }()

    private var subtitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constants.FontSize.size13)
        label.textColor = .black
        label.text = "Character"

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

        self.title.snp.updateConstraints { (make) in
            make.top.equalTo(self.coverImage.snp.bottom)
                .offset(self.titleEdgeInsets.top)
            make.left.right.equalToSuperview()
                .offset(self.titleEdgeInsets.left)
        }

        self.subtitle.snp.updateConstraints { (make) in
            make.top.equalTo(self.title.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview().offset(5)
        }

        super.updateConstraints()
    }

    func set(person: MWCast) {
        if let imageData = person.image, let image = UIImage(data: imageData) {
            self.coverImage.image = image
        } else {
            self.coverImage.image = UIImage(named: Constants.Images.defaultPerson)
        }
        self.title.text = person.name
        self.subtitle.text = person.character

        self.setNeedsUpdateConstraints()
    }
}
