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
    
    private let tableViewInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
    private let categories: [String] = ["New", "Moves", "Series and Shows", "Animated movies"]
    private var selectCategory: String?
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.allowsSelection = false
        tableView.register(MWMainTableCell.self,
                           forCellReuseIdentifier: MWMainTableCell.reuseIdentifier)
        tableView.register(MWMainTableHeader.self,
                           forHeaderFooterViewReuseIdentifier: MWMainTableHeader.headerReuseId)
        
        return tableView
    } ()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
            
        self.tableView.delegate = self
        self.tableView.dataSource = self
                
        self.tableViewPosition()
        self.tableView.reloadData()
    }
    
    //MARK: - Data initlisers methods
    
    fileprivate func setupData() {
        self.view.backgroundColor = .white
        self.navigationItem.title = "Seasons"
        
        self.view.addSubview(self.tableView)
    }
    
    func tableViewPosition() {
        self.tableView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview().inset(self.tableViewInsets)
        }
    }
       
}

extension MWMainViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - TableView Delegate and DataSource Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  self.categories.count
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MWMainTableCell.reuseIdentifier,
                                                       for: indexPath) as? MWMainTableCell else {
            return MWMainTableCell()
        }
        
        cell.cellDelegate = self
        
        return cell
    }
    
    //MARK: - TableView Header
    
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {        
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MWMainTableHeader.headerReuseId) as? MWMainTableHeader else {
            return MWMainTableHeader()
        }
        
        header.titleLabel.text = self.categories[section]
        header.allButton.addTarget(self, action: #selector(self.headerAllButtonClicked), for: .touchUpInside)
        
        return header
    }
    
    //MARK: - Selector action methods
      
    @objc
    func headerAllButtonClicked() {
        let moviesInSection = MWMainAllMoviesViewController()
        moviesInSection.title = "All Movies"
        moviesInSection.view.backgroundColor = .white
        
        MWI.sh.push(vc: moviesInSection)
    }
    
}


extension MWMainViewController: MWMainCollectionCellDelegate {
    
    func collectionView(collectionCell: MWMainCollectionCell?,
                        didTappedInTableview TableCell: MWMainTableCell) {
        
        let moviesInSection = MWViewController()
        moviesInSection.title = "21 Bridges"
        moviesInSection.view.backgroundColor = .white
        
        MWI.sh.push(vc: moviesInSection)
    }
}
