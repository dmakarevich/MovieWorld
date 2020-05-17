//
//  MWActorDescription.swift
//  MovieWorld
//
//  Created by Admin on 16.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import SnapKit

class MWActorDescriptionView: UIView {
    //MARK: - Variables
    private let titleEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 16, right: 16)
    private let descriptionEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 8, right: 16)

    //MARK: - Gui variables
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = UIColor(named: Constants.Colors.textColor)
        label.text = "Biography"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping

        return label
    } ()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor(named: Constants.Colors.textColor)
        label.text = "Some description about movie..."
        label.sizeToFit()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping

        return label
    } ()

    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(self.titleLabel)
        self.addSubview(self.descriptionLabel)
        self.makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Add Constraints
    func makeConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview().inset(self.titleEdgeInsets.top)
        }

        self.descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(self.descriptionEdgeInsets.top)
            make.left.right.equalToSuperview().inset(self.descriptionEdgeInsets)
            make.bottom.equalToSuperview()
        }
    }

    func setData(description: String, runtime: String?, isAdult: Bool = false) {
        self.descriptionLabel.text = description
    }
}
