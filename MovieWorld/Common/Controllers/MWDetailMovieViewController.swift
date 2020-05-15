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
    private var detailMovie: MWDetailMovie?
    private var movieCard = MWMovieCardView()
    private var descriptionBlock = MWDescriptionView()
    private var movieCrewHeader = MWHeaderView()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    private let movieCardEdges = UIEdgeInsets(top: 16, left: 0, bottom: 12, right: 0)
    private let descriptionBlockEdges = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    private let movieCrewHeaderEdges = UIEdgeInsets(top: 24, left: 16, bottom: 12, right: 26)

    private let contentView = UIView()

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
            make.bottom.lessThanOrEqualTo(self.contentView.snp.bottom).inset(self.descriptionBlockEdges.bottom)
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
        self.movieCrewHeader.set(title: "Cast")
    }

    func setData() {
        if let movie = self.detailMovie {
            self.movieCard.setData(movie: movie)
            self.descriptionBlock.setData(description: movie.description, runtime: movie.getRuntime(), isAdult: movie.adult)
        }

        self.makeConstraints()
    }

    func getImage(model: MWDetailMovie) {
        self.detailMovie = model
        let handler: CompetionImageHandler = { (data) in
            guard let data = data else { return }
            self.detailMovie?.image = data

            self.setData()
        }

        MWNet.sh.getImage(imagePath: model.poster,
                          size: .w154,
                          handler: handler)
    }

    func getMovie(movieId: Int) {
        let success: SuccessHandler = { [weak self] (response: MWDetailMovie) in
            guard let self = self else { return }

            debugPrint("~~~~~~~~~~~~~~~~~~~~~")
            debugPrint("backdropPath = \(response.backdropPath)")
            debugPrint("poster = \(response.poster)")
            debugPrint("~~~~~~~~~~~~~~~~~~~~~")
            if let sizes = MWSys.sh.configuration?.posterSizes {
                sizes.forEach({ (size) in
                    debugPrint(size.rawValue)
                })
            }
            self.getImage(model: response)
        }

        let url: String = URLPaths.movieById + String(movieId)

        MWNet.sh.request(urlPath: url,
                         queryParameters: ["language": URLLanguage.by.urlValue],
                         of: MWDetailMovie.self,
                         successHandler: success)
    }
}
