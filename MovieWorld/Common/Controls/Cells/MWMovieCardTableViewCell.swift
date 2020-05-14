//
//  MWMovieCardCell.swift
//  MovieWorld
//
//  Created by Admin on 27.03.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class MWMovieCardTableViewCell: UITableViewCell {
    //MARK: - Variables
    static var cellReuseIdentifier: String = "MWMovieCardTableViewCell"

    var cellContentView: MWMovieCardView = MWMovieCardView()

    //MARK: - Add constraints
    override func updateConstraints() {
        self.cellContentView.snp.updateConstraints { make in
            make.edges.equalToSuperview()
        }

        super.updateConstraints()
    }

    //MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.contentView.addSubview(self.cellContentView)
        self.updateConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(movie: MWMovie?) {
        if let movie = movie {
            self.cellContentView.setData(movie: movie)

            self.setNeedsUpdateConstraints()
        }
    }
}
