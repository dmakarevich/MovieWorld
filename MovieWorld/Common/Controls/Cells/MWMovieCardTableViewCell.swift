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
    
    var contentCellView: MWShadowView = MWShadowView()
    var cellView: MWMovieCardView = MWMovieCardView()
    
    private var contentCellViewInsets = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
    
    //MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.cellView.initialize()
        self.initCellData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initCellData() {
        self.contentView.addSubview(self.contentCellView)
        self.contentCellView.addSubview(self.cellView)
        
        self.makeConstraint()
    }
    
    //MARK: - Add constraints
    
    private func makeConstraint() {
        self.cellView.snp.makeConstraints{ make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        self.contentCellView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
                .inset(self.contentCellViewInsets)
        }
    }
}
