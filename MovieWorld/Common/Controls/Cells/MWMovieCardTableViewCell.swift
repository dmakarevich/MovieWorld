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
    
    class var cellReuseIdentifier: String {
        return "MovieCardCell"
    }
    
    var cellContentView: MWMovieCardView = MWMovieCardView()
    
    private var cellContentViewInsets = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
    
    //MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.cellContentView)
        
        self.makeConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Add constraints
    
    private func makeConstraint() {
        self.cellContentView.snp.makeConstraints{ make in
            make.top.left.right.bottom.equalToSuperview()
            .inset(self.cellContentViewInsets)
        }
    }
}
