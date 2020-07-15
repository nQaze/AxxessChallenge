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
    
    private var tableView: UITableView!
    private var collectionView: UICollectionView!
    private var uisegmentedControl: UISegmentedControl!
    private var apiDataController: APIDataController!
    private var dataToken: NotificationToken?
    private var data: Results<DBDataObj>?
    private var textData: Results<DBDataObj>?
    private var imageData: Results<DBDataObj>?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Axxess Challege!"
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = textData?[indexPath.item]
        
        let detailsVC = DetailsVC()
        detailsVC.data = data
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ListVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return imageData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DataGridCell.identifier, for: indexPath) as! DataGridCell
        cell.data = imageData?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = imageData?[indexPath.item]
        
        let detailsVC = DetailsVC()
        detailsVC.data = data
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
}

extension ListVC {
    
    func setupUI(){
        self.view.backgroundColor = UIColor.white
        setupTableView()
        setupCollectionView()
        setupSegmentedControlView()
        
        applyUIConstraints()
        showTableView()
    }
    
    func setupTableView(){
        tableView = UITableView(frame: .zero)
        tableView.backgroundColor = UIColor.white
        
        tableView.register(DataCell.self, forCellReuseIdentifier: DataCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self

        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        self.view.addSubview(tableView)
    }
    
    func setupCollectionView(){
        
        let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let columnLayout = ColumnFlowLayout(
            cellsPerRow: 2,
            minimumInteritemSpacing: 10,
            minimumLineSpacing: 10,
            sectionInset: sectionInsets,
            cellHeigtAspect: 1.1
        )
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: columnLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.collectionViewLayout = columnLayout
        collectionView.alwaysBounceVertical = true
        
        collectionView.register(DataGridCell.self, forCellWithReuseIdentifier: DataGridCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
               
        self.view.addSubview(collectionView)
    }
    
    func setupSegmentedControlView() {
        let segmentItems = ["Texts", "Images"]
        uisegmentedControl = UISegmentedControl(items: segmentItems)
        uisegmentedControl.frame = .zero
        uisegmentedControl.addTarget(self, action: #selector(segmentControl(_:)), for: .valueChanged)
        uisegmentedControl.selectedSegmentIndex = 0
        self.view.addSubview(uisegmentedControl)
    }
    
    func applyUIConstraints(){
        uisegmentedControl.snp.makeConstraints {
            $0.left.equalToSuperview().offset(12)
            $0.right.equalToSuperview().offset(-12)
            $0.top.equalTo(self.topLayoutGuide.snp.bottom).offset(12)
        }
        
        collectionView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(0)
            $0.right.equalToSuperview().offset(0)
            $0.bottom.equalToSuperview().offset(0)
            $0.top.equalTo(uisegmentedControl.snp.bottom).offset(12)
        }
        
        tableView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(0)
            $0.right.equalToSuperview().offset(0)
            $0.bottom.equalToSuperview().offset(0)
            $0.top.equalTo(uisegmentedControl.snp.bottom).offset(12)
        }
    }
    
    @objc func segmentControl(_ segmentedControl: UISegmentedControl) {
       switch (segmentedControl.selectedSegmentIndex) {
          case 0:
             showTableView()
            break
          case 1:
             showCollectionView()
            break
          default:
            break
       }
    }
    
    func showTableView(){
        collectionView.isHidden = true
        tableView.isHidden = false
    }
    
    func showCollectionView(){
        tableView.isHidden = true
        collectionView.isHidden = false
    }
    
}
