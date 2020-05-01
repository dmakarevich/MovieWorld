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
    private var categoriesFilters: [MWCategory] = MWSys.sh.movieGenres ?? [MWCategory(id: 123, name: "Comedy"), MWCategory(id: 2546, name: "Drama")]
    private var movies: [MWMovie]?
    private var tableCellHieght: CGFloat = 125
    private var collectionViewHieght: CGFloat = 92
    
    // MARK: - Gui variables
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
    
    //MARK: - Data initializers methods
    fileprivate func setupData() {
        self.view.backgroundColor = .white
        self.navigationItem.title = "Movies"
        self.fetchMovies()
        
        self.view.addSubview(self.collectionView)
        self.view.addSubview(self.tableView)
    }
    
    func fetchMovies() {
        let success: SuccessHandler = { (response: MWResponseMovie) in
            let myMovies: [MWMovie] = response.results
            
            self.movies = myMovies
            self.tableView.reloadData()
        }
        
        MWNet.sh.request(URLPaths.nowPlayingMovies,
                         ["language": URLLanquage.by.urlValue],
                         of: MWResponseMovie.self,
                         successHandler: success)
    }
    
    //MARK: - Constraints
    func makeConstraints() {
        self.collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(self.collectionViewHieght)
        }
        
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.collectionView.snp.bottom)
            make.bottom.left.right.equalToSuperview()
        }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupData()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.makeConstraints()
        
        self.tableView.reloadData()
        self.flowLayout.invalidateLayout()
        self.collectionView.reloadData()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateCategories),
                                               name: Constants.NCNames.categories,
                                               object: nil)
    }
    
    //MARK: - Action Selectors
    @objc
    func updateCategories() {
        self.categoriesFilters = MWSys.sh.movieGenres ?? [MWCategory(id: 0, name: "None")]
        self.collectionView.reloadData()
    }
}

//MARK: - Extension for protols UICollectionViewDelegate and UICollectionViewDataSource
extension MWMainAllMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categoriesFilters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MWFilterCategoriesCollectionViewCell.cellReuseIdentifier,
                                                            for: indexPath) as? MWFilterCategoriesCollectionViewCell else {
                                                                return MWFilterCategoriesCollectionViewCell()
        }
        cell.filterLabel.text = self.categoriesFilters[indexPath.row].name
        
        return cell
    }
}

//MARK: - Extension for UICollectionViewDelegateFlowLayout
extension MWMainAllMoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellSize = CGSize()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MWFilterCategoriesCollectionViewCell.cellReuseIdentifier,
                                                         for: indexPath) as? MWFilterCategoriesCollectionViewCell {
            let count = self.categoriesFilters.count
            if count > indexPath.row {
                let category = self.categoriesFilters[indexPath.row].name
                let fontAttributes = [NSAttributedString.Key.font: cell.filterLabel.font]
                let width = category.size(withAttributes: fontAttributes).width
                cellSize = CGSize(width: width + 24, height: 26)
            }
        }
        
        return cellSize
    }
}

//MARK: - Extension for protocols UITableViewDelegate and UITableViewDataSource
extension MWMainAllMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return  1
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return self.movies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableCellHieght
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MWMovieCardTableViewCell.cellReuseIdentifier,
                                                       for: indexPath) as? MWMovieCardTableViewCell else {
                                                        return MWMovieCardTableViewCell()
        }
        if let movie = movies?[indexPath.row] {
            cell.cellContentView.title.text = movie.title
            cell.cellContentView.subtitle.text = String.init(movie.getReleaseYear()) + Constants.commaDelimiter + movie.originalLanguage
            cell.cellContentView.categories.text = movie.getCategoryString()
        }
        
        return cell
    }
}
