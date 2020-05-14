//
//  MWHeaderView.swift
//  MovieWorld
//
//  Created by Admin on 13.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class MWHeaderView: UIView {
    // MARK: - Variables
    private let allLabelSize = CGSize(width: 52, height: 24)
    private let viewInsets = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 7)

    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: Constants.FontSize.size24, weight: .bold)
        label.textColor = UIColor(named: Constants.Colors.textColor)
        label.text = Constants.MainTableHeader.nameCategory

        return label
    } ()

    private lazy var allLabel: UILabel = {
        var label = UILabel()
        label.text = Constants.MainTableHeader.allButton
        label.font = .systemFont(ofSize: Constants.FontSize.size13)
        label.textColor = .white
        label.backgroundColor = UIColor(named: Constants.Colors.accentColor)
        label.cornerRadius = Constants.buttonCornerRadius
        label.textAlignment = .center

        return label
    } ()

    // MARK: - Add Constraints
    override func updateConstraints() {
        self.titleLabel.snp.updateConstraints { (make) in
            make.top.left.bottom.equalToSuperview().inset(self.viewInsets)
        }

        self.allLabel.snp.makeConstraints{ (make) in
            make.size.equalTo(self.allLabelSize)
            make.right.equalToSuperview().inset(self.viewInsets.right)
            make.center.equalTo(self.titleLabel.snp.center)
        }

        super.updateConstraints()
    }

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .white
        self.addSubview(self.titleLabel)
        self.addSubview(self.allLabel)
        self.updateConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(title: String) {
        self.titleLabel.text = title
        self.setNeedsUpdateConstraints()
    }
}
