//
//  MWDetailMovieViewController.swift
//  MovieWorld
//
//  Created by Admin on 11.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class MWDetailMovieViewController: MWViewController {
    //MARK: - Variables
    private let movieCardEdges = UIEdgeInsets(top: 16, left: 0, bottom: 12, right: 0)
    private let descriptionBlockEdges = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    private let movieCrewHeaderEdges = UIEdgeInsets(top: 24, left: 16, bottom: 12, right: 26)
    private let collectionViewEdges = UIEdgeInsets(top: 4, left: 16, bottom: 12, right: 0)

    private var detailMovie: MWDetailMovie?
    private var movieCrew: MWMovieCrew?

    // MARK: - Gui variables
    private let contentView = UIView()
    private var movieCard = MWMovieCardView()
    private var descriptionBlock = MWDescriptionView()
    private var movieCrewHeader = MWHeaderView()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()

    //MARK: - Gui variables
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 72, height: 130)
        flowLayout.minimumInteritemSpacing = 16.0
        flowLayout.sectionInset.bottom = 5

        return flowLayout
    } ()

    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        cv.dataSource = self
        cv.delegate = self
        cv.register(MWCastCollectionViewCell.self, forCellWithReuseIdentifier: MWCastCollectionViewCell.cellReuseIdentifier)
        cv.backgroundColor = .white

        return cv
    } ()

    //MARK: - Add constraints
    func makeConstraints() {
        self.scrollView.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.top.bottom.equalToSuperview()
        })
        self.contentView.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.scrollView.snp.centerX)
            make.width.equalTo(self.scrollView.snp.width)
            make.top.bottom.equalTo(self.scrollView)
        })

        self.movieCard.snp.makeConstraints({ (make) in
            make.top.left.right.equalTo(self.contentView).inset(self.movieCardEdges)
        })

        self.descriptionBlock.snp.makeConstraints({ (make) in
            make.top.equalTo(self.movieCard.snp.bottom)
            make.left.right.equalTo(self.contentView)
        })

        self.movieCrewHeader.snp.makeConstraints({ (make) in
            make.top.equalTo(self.descriptionBlock.snp.bottom)
            make.left.right.equalTo(self.contentView).inset(self.movieCrewHeaderEdges)
        })

        self.collectionView.snp.makeConstraints({ (make) in
            make.top.equalTo(self.movieCrewHeader.snp.bottom).offset(self.collectionViewEdges.top)
            make.left.right.equalToSuperview().inset(self.collectionViewEdges)
            make.height.equalTo(155)
            make.bottom.lessThanOrEqualTo(self.contentView.snp.bottom).inset(self.collectionViewEdges.bottom)
        })
    }

    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }

    func setupViews(){
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.contentView)
        self.contentView.addSubview(self.movieCard)
        self.contentView.addSubview(self.descriptionBlock)
        self.contentView.addSubview(self.movieCrewHeader)
        self.contentView.addSubview(self.collectionView)
        self.movieCrewHeader.set(title: "Cast")
    }

    func setData() {
        if let movie = self.detailMovie {
            self.movieCard.setData(movie: movie)
            self.descriptionBlock.setData(description: movie.description,
                                          runtime: movie.getRuntime(),
                                          isAdult: movie.adult)
        }

        self.makeConstraints()
    }

    func getImage(model: MWDetailMovie) {
        self.detailMovie = model
        let handler: CompetionImageHandler = { (data) in
            guard let data = data else { return }
            self.detailMovie?.image = data

            self.fetchMovieCredits(movieId: model.id)
        }

        MWNet.sh.requestImage(imagePath: model.poster,
                          size: .w154,
                          handler: handler)
    }

    func getMovie(movieId: Int) {
        let success: SuccessHandler = { [weak self] (movie: MWDetailMovie) in
            guard let self = self else { return }

            if let sizes = MWSys.sh.configuration?.posterSizes {
                sizes.forEach({ (size) in
                    debugPrint(size.rawValue)
                })
            }
            self.getImage(model: movie)
            self.fetchMovieCredits(movieId: movie.id)
        }

        let errors = { (error: MWNetError) in
            print(error)
        }

        let url: String = URLPaths.movieById + String(movieId)

        MWNet.sh.requestAlamofire(url: url,
                         parameters: ["language": URLLanguage.by.urlValue],
                         successHandler: success,
                         errorHandler: errors)
    }

    func fetchMovieCredits(movieId: Int) {
        let success: SuccessHandler = { [weak self] (movieCrew: MWMovieCrew) in
            guard let self = self else { return }
            self.getCastImage(crew: movieCrew)
        }

        let errors = { (error: MWNetError) in
            print(error)
        }
        let url = "/movie/\(movieId)/credits"
        let params = ["language": URLLanguage.by.urlValue]

        MWNet.sh.requestAlamofire(url: url,
                         parameters: params,
                         successHandler: success,
                         errorHandler: errors)
    }

    func getCastImage(crew: MWMovieCrew) {
        let dispatch = DispatchGroup()
        crew.cast.forEach ({ (person) in
            let completion: CompetionImageHandler = { (data) in
                person.image = data
                dispatch.leave()
            }

            guard let path = person.profilePath else { return }
            dispatch.enter()
            MWNet.sh.requestImage(imagePath: path,
                              size: .w92,
                              handler: completion)
        })

        dispatch.notify(queue: .main) {
            self.movieCrew = crew

            self.setData()
            self.collectionView.reloadData()
        }
    }
}

//MARK: - Collection view Datasource and Delegate Methods
extension MWDetailMovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movieCrew?.cast.count ?? 1
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MWCastCollectionViewCell.cellReuseIdentifier, for: indexPath)

        if let person = self.movieCrew?.cast[indexPath.row] {
            (cell as? MWCastCollectionViewCell)?.set(person: person)
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as? MWCastCollectionViewCell
        let moviesInSection = MWDetailMovieViewController()
        moviesInSection.view.backgroundColor = .white

//        if let id = cell?.movieId {
//            moviesInSection.getMovie(movieId: id)
//
//            MWI.sh.push(vc: moviesInSection)
//        }
    }
}
