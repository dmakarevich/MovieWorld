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
    private let viewInsets = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)

    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: Constants.FontSize.size24,
                                 weight: .bold)
        label.textColor = UIColor(named: Constants.Colors.textColor)
        label.text = Constants.MainTableHeader.nameCategory

        return label
    } ()

    private lazy var allView: MWAllView = {
        var view = MWAllView()
        view.backgroundColor = UIColor(named: Constants.Colors.accentColor)
        view.cornerRadius = Constants.buttonCornerRadius

        return view
    } ()

    // MARK: - Add Constraints
    func makeConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview().inset(self.viewInsets)
        }

        self.allView.snp.makeConstraints{ (make) in
            make.right.equalToSuperview().inset(self.viewInsets.right)
            make.centerY.equalTo(self.titleLabel.snp.centerY)
        }
    }

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .white
        self.addSubview(self.titleLabel)
        self.addSubview(self.allView)
        self.makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(title: String) {
        self.titleLabel.text = title
    }
}
