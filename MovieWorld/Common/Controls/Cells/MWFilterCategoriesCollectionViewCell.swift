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
    static let cellReuseIdentifier: String = "MWFilterCategoriesCollectionViewCell"

    private lazy var filterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .white
        label.text = "Category"

        return label
    }()

    //MARK: - Add Constraints
    override func updateConstraints() {
        self.filterLabel.snp.updateConstraints { (make) in
            make.center.equalToSuperview()
            make.top.left.greaterThanOrEqualToSuperview()
            make.bottom.right.lessThanOrEqualToSuperview()
        }
        super.updateConstraints()
    }

    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.cornerRadius = Constants.buttonCornerRadius
        self.contentView.addSubview(self.filterLabel)
        self.backgroundColor = UIColor(named: Constants.Colors.accentColor)?.withAlphaComponent(0.5)
        self.updateConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Action set label
    func set(filter: String) {
        self.filterLabel.text = filter
        self.setNeedsUpdateConstraints()
    }
}
