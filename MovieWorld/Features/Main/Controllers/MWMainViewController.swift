//
//  MWMainViewController.swift
//  MovieWorld
//
//  Created by Admin on 09.03.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SnapKit

typealias MoviesCatalog = (String, [MWMovie])

class MWMainViewController: MWViewController {
    // MARK: - Variables
    private let tableViewInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 0)
    private var categories: [String] = ["Now Playing", "Popular", "Top Rated", "Upcoming"]
    private var popularMovies: [MWMovie]?
    private var selectCategory: String?
    private let tableCellHeight: CGFloat = 240

    // MARK: - Gui variables
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MWMainTableCell.self,
                           forCellReuseIdentifier: MWMainTableCell.reuseIdentifier)
        tableView.register(MWMainTableHeader.self,
                           forHeaderFooterViewReuseIdentifier: MWMainTableHeader.headerReuseId)

        return tableView
    } ()

    //MARK: - Fetch data for initialization
    private func setupData() {
        self.view.addSubview(self.tableView)
        self.makeContraints()
    }

    func fetchPopularMovies() {
        let success: SuccessHandler = { [weak self] (responseData: MWResponseMovie) in
            guard let self = self else { return }
            let movies: [MWMovie] = responseData.results

            self.fetchImages(movies: movies)
        }

        MWNet.sh.request(urlPath: URLPaths.popularMovies,
                         queryParameters: ["language": URLLanguage.by.urlValue],
                         of: MWResponseMovie.self,
                         successHandler: success)
    }

    func fetchImages(movies: [MWMovie]) {
        let dispatch = DispatchGroup()
        movies.forEach ({ (movie) in
            let completion: CompetionImageHandler = { (data) in
                movie.image = data
                dispatch.leave()
            }

            dispatch.enter()
            MWNet.sh.getImage(imagePath: movie.poster,
                              size: .w185,
                              handler: completion)
        })

        dispatch.notify(queue: .main) {
            self.popularMovies = movies
            self.setupData()
        }
    }

    //MARK: - Data initlisers methods
    func makeContraints() {
        self.tableView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(self.tableViewInsets)
            make.left.right.equalToSuperview().inset(self.tableViewInsets)
        }
    }

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.navigationItem.title = "Seasons"
        self.fetchPopularMovies()
    }
}

//MARK: - TableView Delegate and DataSource Methods
extension MWMainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return  self.categories.count
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableCellHeight
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MWMainTableCell.reuseIdentifier,
        for: indexPath)
        (cell as? MWMainTableCell)?.set(movies: self.popularMovies)

        return cell
    }

    //MARK: - TableView Header
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MWMainTableHeader.headerReuseId)
        (header as? MWMainTableHeader)?.set(title: self.categories[section])

        let headerTapGesture = UITapGestureRecognizer(target: self,
                               action: #selector(self.headerAllButtonClicked))
        headerTapGesture.numberOfTapsRequired = 1
        header?.addGestureRecognizer(headerTapGesture)

        return header
    }

    //MARK: - Selector action methods
    @objc func headerAllButtonClicked() {
        let moviesInSection = MWMainAllMoviesViewController()
        moviesInSection.title = "Movies"
        moviesInSection.view.backgroundColor = .white

        MWI.sh.push(vc: moviesInSection)
    }
}
