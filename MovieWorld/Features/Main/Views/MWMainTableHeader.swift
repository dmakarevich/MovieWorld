//
//  MWMainTableHeader.swift
//  MovieWorld
//
//  Created by Admin on 19.03.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class MWMainTableHeader: UITableViewHeaderFooterView {
    // MARK: - Variables
    static var headerReuseId: String {
        return "MWMainTableHeader"
    }

    private var headerView = MWHeaderView()

    // MARK: - Add Constraints
    override func updateConstraints() {
        self.headerView.snp.updateConstraints { (make) in
            make.edges.equalToSuperview()
        }

        super.updateConstraints()
    }

    // MARK: - Initialization
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.translatesAutoresizingMaskIntoConstraints = false

        self.contentView.addSubview(self.headerView)
        self.updateConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(title: String) {
        self.headerView.set(title: title)
        self.setNeedsUpdateConstraints()
    }
}
