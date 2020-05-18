//
//  MWActorView.swift
//  MovieWorld
//
//  Created by Admin on 16.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class MWActorCardView: MWShadowView {
    //MARK: - Variables
    private let imageSize = CGSize(width: 70, height: 90)
    private let coverImageEdgeInsets = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 8)
    private let titleEdgeInsets = UIEdgeInsets(top: 10, left: 16, bottom: 3, right: 30)
    private let ageEdgeInsets = UIEdgeInsets(top: 30, left: 16, bottom: 10, right: 30)

    private lazy var coverImage: UIImageView = {
        let iv = UIImageView()
        iv.cornerRadius = 5
        iv.image = UIImage(named: Constants.Images.defaultMovie)

        return iv
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = UIColor(named: Constants.Colors.textColor)
        label.text = "Name"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping

        return label
    }()

    private lazy var ageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(named: Constants.Colors.textColor)?.withAlphaComponent(0.5)
        label.text = "Birthday, y.o."
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping

        return label
    } ()

    //MARK: - Initialize
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(self.coverImage)
        self.addSubview(self.nameLabel)
        self.addSubview(self.ageLabel)

        self.makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Add Constraints
    private func makeConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.coverImage.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().inset(self.coverImageEdgeInsets)
            make.size.equalTo(self.imageSize)
            make.bottom.lessThanOrEqualToSuperview().inset(self.coverImageEdgeInsets.bottom)
        }

        self.nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(self.titleEdgeInsets.top)
            make.left.equalTo(self.coverImage.snp.right).offset(self.titleEdgeInsets.left)
            make.right.equalToSuperview().inset(self.titleEdgeInsets.right)
        }

        self.ageLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.nameLabel.snp.bottom).offset(ageEdgeInsets.top)
            make.left.equalTo(self.coverImage.snp.right).offset(self.ageEdgeInsets.left)
            make.right.equalToSuperview().inset(self.ageEdgeInsets.right)
            make.bottom.lessThanOrEqualToSuperview().inset(self.ageEdgeInsets.bottom)
        }
    }

    func setData(actor: MWActor) {
        self.nameLabel.text = actor.name
        self.ageLabel.text = actor.getBirdayAndYears()
        var image: UIImage?
        if let imagedata = actor.image, let img = UIImage(data: imagedata) {
            image = img
        } else {
            image = UIImage(named: Constants.Images.defaultPerson)
        }
        self.coverImage.image = image
    }

}
