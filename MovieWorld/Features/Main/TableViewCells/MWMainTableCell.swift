//
//  MWMainTableCell.swift
//  MovieWorld
//
//  Created by Admin on 23.03.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SnapKit


protocol MWMainCollectionCellDelegate: class {
    func collectionView(collectionCell: MWMainCollectionCell?,
                        didTappedInTableview TableCell: MWMainTableCell)
}

class MWMainTableCell: UITableViewCell {
    //MARK: - Variables    
    static var reuseIdentifier: String {
        return "MWMainTableCell"
    }
    
    weak var cellDelegate: MWMainCollectionCellDelegate?
    var movies: [MWMovie]?
    
    private let collectionViewInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
    
    //MARK: - Gui variables    
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 130, height: 237)
        flowLayout.minimumInteritemSpacing = 8.0
        flowLayout.sectionInset.bottom = 12
        
        return flowLayout
    } ()
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        cv.backgroundColor = .white
        cv.register(MWMainCollectionCell.self, forCellWithReuseIdentifier: MWMainCollectionCell.cellReuseIdentifier)
        
        return cv
    } ()
    
    //MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(collectionView)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Constraints
    func makeConstraints() {
        self.collectionView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalToSuperview().inset(self.collectionViewInsets)
        }
    }
}

//MARK: - Collection view Datasource and Delegate Methods
extension MWMainTableCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MWMainCollectionCell.cellReuseIdentifier, for: indexPath) as? MWMainCollectionCell else {
            return MWMainCollectionCell()
        }
        if let movies = self.movies {
            let movie = movies[indexPath.row]
            cell.title.text = movie.title
            cell.movieId = movie.id
            cell.subtitle.text = movie.getReleaseYear() + Constants.commaDelimiter + movie.originalLanguage
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? MWMainCollectionCell
        
        self.cellDelegate?.collectionView(collectionCell: cell, didTappedInTableview: self)
    }
}
