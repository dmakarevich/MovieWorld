//
//  MWAllView.swift
//  MovieWorld
//
//  Created by Admin on 15.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class MWAllView: UIView {
    // MARK: - Variables
    private let allLabelEdges = UIEdgeInsets(top: 4, left: 12, bottom: 4, right: 12)

    private lazy var allLabel: UILabel = {
        var label = UILabel()
        label.text = Constants.MainTableHeader.allButton
        label.font = .systemFont(ofSize: Constants.FontSize.size13)
        label.textColor = .white
        label.textAlignment = .center

        return label
    } ()

    // MARK: - Add Constraints
    func makeConstraints() {
        self.allLabel.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview().inset(self.allLabelEdges)
        })
    }

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(self.allLabel)
        self.makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
