//
//  MWMainViewController.swift
//  MovieWorld
//
//  Created by Admin on 09.03.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import SnapKit



class MWMainViewController: MWViewController {
    // MARK: - Variables
    private let tableViewInsets = UIEdgeInsets(top: 12, left: 16, bottom: 0, right: 0)
    private var categories: [String] = ["Now Playing", "Popular", "Top Rated", "Upcoming"]
    private var popularMovies: [MWMovie]?
    private var selectCategory: String?
    private let tableHeaderHeight: CGFloat = 56
    private let tableCellHeight: CGFloat = 249
    
    // MARK: - Gui variables
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.allowsSelection = false
        tableView.register(MWMainTableCell.self,
                           forCellReuseIdentifier: MWMainTableCell.reuseIdentifier)
        tableView.register(MWMainTableHeader.self,
                           forHeaderFooterViewReuseIdentifier: MWMainTableHeader.headerReuseId)
        
        return tableView
    } ()
    
    //MARK: - Fetch data for initialization
    private func setupData() {
        self.view.backgroundColor = .white
        self.navigationItem.title = "Seasons"
        self.fetchPopularMovies()
        
        self.view.addSubview(self.tableView)
    }
    
    func fetchPopularMovies() {
        let success: SuccessHandler = { (responseData: MWResponseMovie) in
            let movies: [MWMovie] = responseData.results
            self.popularMovies = movies

            self.tableView.reloadData()
        }
        
        MWNet.sh.request(URLPaths.popularMovies,
                         ["language": URLLanquage.by.urlValue],
                         of: MWResponseMovie.self,
                         successHandler: success)
    }
    
    //MARK: - Data initlisers methods
    func makeContraints() {
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(self.tableViewInsets)
            make.bottom.left.right.equalToSuperview().inset(self.tableViewInsets)
        }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.makeContraints()
        self.tableView.reloadData()
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
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: MWMainTableCell.reuseIdentifier,
                                 for: indexPath) as? MWMainTableCell else {
                                    return MWMainTableCell()
        }
        cell.cellDelegate = self
        cell.movies = self.popularMovies
        cell.collectionView.reloadData()
        
        return cell
    }
    
    //MARK: - TableView Header
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        return self.tableHeaderHeight
    }
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {        
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MWMainTableHeader.headerReuseId) as? MWMainTableHeader else {
            return MWMainTableHeader()
        }
        header.titleLabel.text = self.categories[section]
        header.allButton.addTarget(self,
                                   action: #selector(self.headerAllButtonClicked),
                                   for: .touchUpInside)
        
        return header
    }
    
    //MARK: - Selector action methods
    @objc
    func headerAllButtonClicked() {
        let moviesInSection = MWMainAllMoviesViewController()
        moviesInSection.title = "Movies"
        moviesInSection.view.backgroundColor = .white
        
        MWI.sh.push(vc: moviesInSection)
    }
}

//MARK: - MWMainCollectionCellDelegate Method
extension MWMainViewController: MWMainCollectionCellDelegate {
    func collectionView(collectionCell: MWMainCollectionCell?,
                        didTappedInTableview TableCell: MWMainTableCell) {
        let moviesInSection = MWViewController()
        moviesInSection.title = collectionCell?.title.text
        moviesInSection.view.backgroundColor = .white
        
        if let id = collectionCell?.movieId {
            moviesInSection.fetchMovie(movieId: id)
            
            MWI.sh.push(vc: moviesInSection)
        }
    }
}
