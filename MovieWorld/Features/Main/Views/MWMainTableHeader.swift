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
    
    class var headerReuseId: String {
        return "MWMainTableHeader"
    }
    
    var titleLabel = UILabel()
    var allButton = UIButton()
    
    private let allButtonSize = CGSize(width: 52, height: 24)
    private let titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0)
    private let allButtonInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 7)
    
    // MARK: - Initialization
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.allButton)
        
        self.makeConstraints()
        self.initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialize() {
        self.contentView.backgroundColor = .white
        
        self.titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        self.titleLabel.textColor = UIColor(named: "textColor")
        self.titleLabel.text = "Header"
        
        self.allButton.setTitle("All →", for: .normal)
        self.allButton.titleLabel?.font = .systemFont(ofSize: 13)
        self.allButton.backgroundColor = UIColor(named: "accentColor")
        self.allButton.cornerRadius = 5
    }
    
    // MARK: - Add Constraints
    
    func makeConstraints() {
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.bottom.equalTo(self.contentView).inset(self.titleInsets)
        }
        
        self.allButton.snp.makeConstraints{ (make) in
            make.right.equalToSuperview().inset(self.allButtonInsets.right)
            make.size.equalTo(self.allButtonSize)
            make.centerY.equalTo(self.titleLabel.snp.centerY)
        }
    }
        
}
