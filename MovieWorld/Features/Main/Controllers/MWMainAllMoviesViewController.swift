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
    private var categoriesFilters: [MWCategory] = MWSys.sh.movieGenres ?? [MWCategory(id: 0, name: "None")]
    private var movies: [MWMovie]?
    private var moviesInfo: MWResponseMovie?
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
        cv.delegate = self
        cv.dataSource = self
        cv.register(MWFilterCategoriesCollectionViewCell.self,
                    forCellWithReuseIdentifier: MWFilterCategoriesCollectionViewCell.cellReuseIdentifier)

        return cv
    } ()

    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MWMovieCardTableViewCell.self,
                           forCellReuseIdentifier: MWMovieCardTableViewCell.cellReuseIdentifier)
        return tableView
    } ()

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

        Utility.hideActivityIndicator(view: self.view)
        self.setupData()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateCategories),
                                               name: Constants.NCNames.categories,
                                               object: nil)
    }

    //MARK: - Data initializers methods
    fileprivate func setupData() {
        self.view.backgroundColor = .white
        self.navigationItem.title = "Movies"
        self.fetchMovies()

        self.view.addSubview(self.collectionView)
        self.view.addSubview(self.tableView)

        self.makeConstraints()
        Utility.showActivityIndicator(view: self.view)
    }

    func fetchMovies(page: Int = 1) {
        let success: SuccessHandler = { [unowned self] (response: MWResponseMovie) in
            self.moviesInfo = response
            self.fetchImages(movies: response.results)
        }

        let errors = { (error: MWNetError) in
            print(error)
            Utility.hideActivityIndicator(view: self.view)
        }

        let params: [String: String] = ["page": String(page)]

        MWNet.sh.requestAlamofire(url: URLPaths.nowPlayingMovies,
                         parameters: params,
                         successHandler: success,
                         errorHandler: errors)
    }

    func fetchImages(movies: [MWMovie]) {
        let dispatch = DispatchGroup()
        movies.forEach ({ (movie) in
            let completion: CompetionImageHandler = { (data) in
                movie.image = data

                dispatch.leave()
            }

            dispatch.enter()
            MWNet.sh.requestImage(imagePath: movie.poster,
                              size: .w185,
                              handler: completion)
        })

        dispatch.notify(queue: .main) {
            if let info = self.moviesInfo, info.page > 1 {
                movies.forEach({(movie) in
                    self.movies?.append(movie)
                })
            } else {
                self.movies = movies
            }
            self.tableView.reloadData()
            Utility.hideActivityIndicator(view: self.view)
            self.tableView.setNeedsUpdateConstraints()
        }
    }

    //MARK: - Action Selectors
    @objc
    func updateCategories() {
        self.categoriesFilters = MWSys.sh.movieGenres ?? [MWCategory(id: 0, name: "None")]
        self.flowLayout.invalidateLayout()
        self.collectionView.reloadData()
    }
}

//MARK: - Extension for protols UICollectionViewDelegate and UICollectionViewDataSource
extension MWMainAllMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categoriesFilters.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MWFilterCategoriesCollectionViewCell.cellReuseIdentifier,
                                                      for: indexPath)
        (cell as? MWFilterCategoriesCollectionViewCell)?.set(filter: self.categoriesFilters[indexPath.row].name)

        return cell
    }
}

//MARK: - Extension for UICollectionViewDelegateFlowLayout
extension MWMainAllMoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var cellSize = CGSize()
        if collectionView.dequeueReusableCell(withReuseIdentifier: MWFilterCategoriesCollectionViewCell.cellReuseIdentifier,
                                              for: indexPath) is MWFilterCategoriesCollectionViewCell {
            let count = self.categoriesFilters.count
            if count > indexPath.row {
                let category = self.categoriesFilters[indexPath.row].name
                let fontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13)]
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

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MWMovieCardTableViewCell.cellReuseIdentifier,
                                                 for: indexPath)
        (cell as? MWMovieCardTableViewCell)?.set(movie: movies?[indexPath.row])

        return cell
    }

    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        if let movies = self.movies, indexPath.row == movies.count - 3 {
            if let moviesInfo = self.moviesInfo, moviesInfo.hasNextPage() {
                self.fetchMovies(page: moviesInfo.page + 1)
            }
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let id = self.movies?[indexPath.row].id {
            let moviesInSection = MWDetailMovieViewController()
            moviesInSection.initHandler = { () -> Int in
                return id
            }

            MWI.sh.push(vc: moviesInSection)
        }
    }
}
