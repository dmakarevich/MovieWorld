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
    //MARK: - Variables
    static var reuseIdentifier: String = "MWMainTableCell"
    private var movies: [MWMovie]?
    private let collectionViewInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)

    //MARK: - Gui variables
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 130, height: 235)
        flowLayout.minimumInteritemSpacing = 8.0
        flowLayout.sectionInset.bottom = 5

        return flowLayout
    } ()

    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        cv.dataSource = self
        cv.delegate = self

        cv.register(MWMainCollectionCell.self, forCellWithReuseIdentifier: MWMainCollectionCell.cellReuseIdentifier)
        cv.backgroundColor = .white

        return cv
    } ()

    //MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.contentView.addSubview(collectionView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Constraints
    override func updateConstraints() {
        self.collectionView.snp.updateConstraints { (make) in
            make.edges.equalTo(self.contentView).inset(self.collectionViewInsets)
        }

        super.updateConstraints()
    }

    func set(url: String) {
        if self.movies == nil {
            self.fetchMovies(url: url)
            Utility.showActivityIndicator(view: self.contentView)
        }
    }

    private func setData(movies: [MWMovie]?) {
        self.movies = movies
        self.collectionView.reloadData()
        self.setNeedsUpdateConstraints()
    }

    //MARK: - request methods for getting movies
    private func fetchMovies(url: String) {
        let success: SuccessHandler = { [weak self] (responseData: MWResponseMovie) in
            guard let self = self else { return }
            let movies: [MWMovie] = responseData.results

            self.fetchImages(movies: movies)
        }

        let errors = { (error: MWNetError) in
            print(error)
        }

        MWNet.sh.requestAlamofire(url: url,
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
                Utility.hideActivityIndicator(view: self)
                self.setData(movies: movies)
            }
        }
}

//MARK: - Collection view Datasource and Delegate Methods
extension MWMainTableCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies?.count ?? 1
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MWMainCollectionCell.cellReuseIdentifier, for: indexPath)

        if let movie = self.movies?[indexPath.row] {
            (cell as? MWMainCollectionCell)?.set(movie: movie)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? MWMainCollectionCell
        let moviesInSection = MWDetailMovieViewController()

        if let id = cell?.movieId {
            moviesInSection.initHandler = { () -> Int in
                return id
            }

            MWI.sh.push(vc: moviesInSection)
        }
    }
}
