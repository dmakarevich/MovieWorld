//
//  MWDetailActorViewController.swift
//  MovieWorld
//
//  Created by Admin on 16.05.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SnapKit

class MWDetailActorViewController: MWViewController {
    //MARK: - Variables
    var initHandler: (() -> Int)?

    private let movieCardEdges = UIEdgeInsets(top: 16, left: 0, bottom: 12, right: 0)
    private let descriptionBlockEdges = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    private let moviesHeaderEdges = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 26)
    private let collectionViewEdges = UIEdgeInsets(top: 4, left: 16, bottom: 12, right: 0)
    private var movies: [MWMovie]?
    private var detailActor: MWActor?

    // MARK: - Gui variables
    private let contentView = UIView()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()

    private var actorCardView = MWActorCardView()
    private var moviesHeader = MWHeaderView()
    private var descriptionBlock = MWActorDescriptionView()

    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 130, height: 240)
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.sectionInset.bottom = 3

        return flowLayout
    } ()

    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        cv.dataSource = self
        cv.delegate = self
        cv.register(MWMainCollectionCell.self,
                    forCellWithReuseIdentifier: MWMainCollectionCell.cellReuseIdentifier)
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

        self.actorCardView.snp.makeConstraints({ (make) in
            make.top.left.right.equalTo(self.contentView)
        })

        self.moviesHeader.snp.makeConstraints({ (make) in
            make.top.equalTo(self.actorCardView.snp.bottom).offset(self.moviesHeaderEdges.top)
            make.left.right.equalTo(self.contentView).inset(self.moviesHeaderEdges)
        })

        self.collectionView.snp.makeConstraints({ (make) in
            make.top.equalTo(self.moviesHeader.snp.bottom)
            make.left.right.equalTo(self.contentView).inset(self.collectionViewEdges)
            make.height.equalTo(245)
        })

        self.descriptionBlock.snp.makeConstraints({ (make) in
            make.top.equalTo(self.collectionView.snp.bottom).inset(self.descriptionBlockEdges.top)
            make.left.right.equalTo(self.contentView)
            make.bottom.lessThanOrEqualToSuperview().inset(self.descriptionBlockEdges.bottom)
        })
    }

    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.contentView)
        self.contentView.addSubview(self.actorCardView)
        self.contentView.addSubview(self.moviesHeader)
        self.contentView.addSubview(self.collectionView)
        self.contentView.addSubview(self.descriptionBlock)

        let id = self.initHandler?()
        if let id = id {
            self.fetchActorDetail(id: id)
            Utility.showActivityIndicator(view: self.view, targetVC: self)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.disableLargeTitle()
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.enableLargeTitle()
    }

    func setData() {
        if let actor = self.detailActor {
            self.actorCardView.setData(actor: actor)
            self.descriptionBlock.setData(description: actor.biography,
                                          runtime: nil)
            self.moviesHeader.set(title: "Filmography", withoutRightView: true)
        }

        self.makeConstraints()
    }

    func fetchActorDetail(id: Int) {
        let success: SuccessHandler = { [weak self] (actor: MWActor) in
            guard let self = self else { return }

            self.getImage(model: actor)
            self.fetchMoviesWithActor(id: actor.id)
        }

        let errors = { (error: MWNetError) in
            print(error)
        }

        let url: String = URLPaths.actorById + String(id)

        MWNet.sh.requestAlamofire(url: url,
                                  successHandler: success,
                                  errorHandler: errors)
    }

    func getImage(model: MWActor) {
        let handler: CompetionImageHandler = { [weak self] (data) in
            guard let self = self else { return }
            guard let data = data else { return }

            model.image = data
            self.detailActor = model
        }

        MWNet.sh.requestImage(imagePath: model.poster,
                          size: .w154,
                          handler: handler)
    }

    func fetchMoviesWithActor(id: Int) {
        let success: SuccessHandler = { [weak self] (responseMovie: MWResponseMovie) in
            guard let self = self else { return }

            self.getCastImage(models: responseMovie.results)
        }

        let errors = { (error: MWNetError) in
            print(error)
        }

        let params = ["with_people": String(id)]

        MWNet.sh.requestAlamofire(url: URLPaths.discoverMovie,
                                  parameters: params,
                                  successHandler: success,
                                  errorHandler: errors)
    }

    func getCastImage(models: [MWMovie]) {
        let dispatch = DispatchGroup()
        models.forEach ({ (model) in
            let completion: CompetionImageHandler = { (data) in
                model.image = data
                dispatch.leave()
            }

            dispatch.enter()
            MWNet.sh.requestImage(imagePath: model.poster,
                              size: .w92,
                              handler: completion)
        })

        dispatch.notify(queue: .main) {
            self.movies = models
            Utility.hideActivityIndicator(view: self.view)
            self.setData()
            self.collectionView.reloadData()
        }
    }
}

//MARK: - Collection view Datasource and Delegate Methods
extension MWDetailActorViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies?.count ?? 0
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
        let moviesInSection = MWDetailMovieViewController()

        if let id = self.movies?[indexPath.row].id {
            moviesInSection.initHandler = { () -> Int in
                return id
            }

            MWI.sh.push(vc: moviesInSection)
        }
    }
}
