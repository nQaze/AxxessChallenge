//
//  ListVC.swift
//  AxxessChallenge
//
//  Created by Nabil Kazi on 15/07/20.
//  Copyright © 2020 Nabil Kazi. All rights reserved.
//

import UIKit
import SnapKit
import RealmSwift

class ListVC : UIViewController {
    
    private var apiDataController: APIDataController!
    private var tableView: UITableView!
    private var dataToken: NotificationToken?
    private var data: Results<DBDataObj>?
    private var textData: Results<DBDataObj>?
    private var imageData: Results<DBDataObj>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        fetchLocalData()
        fetchAPIData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         
        dataToken = data?.observe { [weak tableView] changes in
            guard let tableView = tableView else { return }
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let updates):
                tableView.applyChanges(deletions: deletions, insertions: insertions, updates: updates)
            case .error: break
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        dataToken?.invalidate()
    }
    
    func fetchLocalData(){
        textData = DBDataObj.find(type: .text)
        imageData = DBDataObj.find(type: .image)
    }
    
    func fetchAPIData(){
        apiDataController = APIDataController()
        apiDataController.fetchData()
    }
    
}

extension ListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textData?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DataCell.identifier, for: indexPath) as! DataCell
        cell.data = textData?[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ListVC {
    
    func setupUI(){
        setupTableView()
        setupCollectionView()
        
        applyUIConstraints()
    }
    
    func setupTableView(){
        tableView = UITableView(frame: .zero)
        
        tableView.register(DataCell.self, forCellReuseIdentifier: DataCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self

        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        self.view.addSubview(tableView)
    }
    
    func setupCollectionView(){
        
    }
    
    func applyUIConstraints(){
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
