//
//  MWMainTableCell.swift
//  MovieWorld
//
//  Created by Admin on 23.03.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SnapKit


class MWMainTableCell: UITableViewCell {
       
    class var reuseIdentifier: String {
        return "MWMainTableCell"
    }
    
    fileprivate let collectionViewInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 130, height: 237)
        flowLayout.minimumLineSpacing = 8.0
        flowLayout.minimumInteritemSpacing = 5.0
                
        return flowLayout
    }()
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(MWMainCollectionCell.self, forCellWithReuseIdentifier: MWMainCollectionCell.cellReuseIdentifier)
        return cv
    } ()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(collectionView)

        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        initialCell()
        makeConstraints()
    }
    
    
    fileprivate func initialCell() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        self.collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top).inset(self.collectionViewInsets.top)
            make.leading.equalTo(self.contentView.snp.leading).inset(self.collectionViewInsets.left)
            make.trailing.equalTo(self.contentView.snp.trailing).inset(self.collectionViewInsets.right)
            make.bottom.equalTo(self.contentView.snp.bottom).inset(self.collectionViewInsets.bottom)
        }
    }
}
 

 
extension MWMainTableCell: UICollectionViewDelegate, UICollectionViewDataSource {

    //MARK: - Collection view datasource and Delegate

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MWMainCollectionCell.cellReuseIdentifier, for: indexPath) as? MWMainCollectionCell else {
            return MWMainCollectionCell()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
}
