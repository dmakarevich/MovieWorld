//
//  MWMainAllMoviesViewController.swift
//  MovieWorld
//
//  Created by Admin on 26.03.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class MWMainAllMoviesViewController: MWViewController {
    
    // MARK: - Variables
    
    private let collecttionViewSectionInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 0)
    
    private let categoriesFilters: [String] = ["Comedy", "Drama", "Foreign",
                                               "Crime", "Fiction", "Musicial",
                                               "Detective", "Documentary", "Adventures",
                                               "Adult", "Action movie"]
        
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()

        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 8.0
        flowLayout.minimumInteritemSpacing = 10.0
        flowLayout.sectionInset = self.collecttionViewSectionInsets
                
        return flowLayout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        cv.backgroundColor = .white
        cv.register(MWFilterCategoriesCollectionViewCell.self,
                    forCellWithReuseIdentifier: MWFilterCategoriesCollectionViewCell.cellReuseIdentifier)
        
        return cv
    } ()
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.register(MWMovieCardTableViewCell.self,
                           forCellReuseIdentifier: MWMovieCardTableViewCell.cellReuseIdentifier)
        return tableView
    } ()
        
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        self.setupData()
                
        self.tableView.delegate = self
        self.tableView.dataSource = self
                
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
                    
        self.tableViewPosition()
        
        self.tableView.reloadData()
        self.collectionView.reloadData()
    }
        
    //MARK: - Data initlisers methods
        
    fileprivate func setupData() {
        self.view.backgroundColor = .white
        self.navigationItem.title = "All Movies"
        
            
        self.view.addSubview(self.collectionView)
        self.view.addSubview(self.tableView)
    }
        
    func tableViewPosition() {
        self.collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(92)
        }
        
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.collectionView.snp.bottom)
            make.bottom.left.right.equalToSuperview()
        }
    }
}

//MARK: - Extension for protols UICollectionViewDelegate and UICollectionViewDataSource

extension MWMainAllMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 11
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MWFilterCategoriesCollectionViewCell.cellReuseIdentifier,
                                                            for: indexPath) as? MWFilterCategoriesCollectionViewCell else {
            return MWFilterCategoriesCollectionViewCell()
        }

        cell.filterLabel.text = self.categoriesFilters[indexPath.row]
        
        return cell
    }
}

extension MWMainAllMoviesViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MWFilterCategoriesCollectionViewCell.cellReuseIdentifier,
                                                            for: indexPath) as? MWFilterCategoriesCollectionViewCell else {
            return CGSize()
        }
        
        let category = self.categoriesFilters[indexPath.row]
        let fontAttributes = [NSAttributedString.Key.font: cell.filterLabel.font!]//UIFont.systemFont(ofSize: 13)]
        let width = category.size(withAttributes: fontAttributes).width

        return CGSize(width: width + 24, height: 26)
    }
}

//MARK: - Extension for protols UITableViewDelegate and UITableViewDataSource

extension MWMainAllMoviesViewController: UITableViewDelegate, UITableViewDataSource {
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return  1
    }
        
    func tableView(_ tableView: UITableView,
                    numberOfRowsInSection section: Int) -> Int {
        return self.categoriesFilters.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
        
    func tableView(_ tableView: UITableView,
                       cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MWMovieCardTableViewCell.cellReuseIdentifier,
                                                 for: indexPath) as? MWMovieCardTableViewCell else {
            return MWMovieCardTableViewCell()
        }
        
        return cell
    }
}
