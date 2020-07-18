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
    
    private var activityIndicator: UIActivityIndicatorView!
    private var tableView: UITableView!
    private var collectionView: UICollectionView!
    private var uisegmentedControl: UISegmentedControl!
    private var apiDataController: APIDataController!
    private var textData: Results<DBDataObj>?
    private var imageData: Results<DBDataObj>?
    private var displayMessage = Constants.noDataMessage

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Axxess Challege!"
        
        setupUI()
        fetchAPIData()
    }
    
    private func setupUI(){
        self.view.backgroundColor = Color.backgroundColor
        setupTableView()
        setupCollectionView()
        setupSegmentedControlView()
        
        applyUIConstraints()
        showTableView()
        setupLoader()
    }
    
    private func fetchAPIData(){
        apiDataController = APIDataController()
        apiDataController.fetchData{ data, error in
            self.activityIndicator.stopAnimating()
            guard let data = data else{
                self.displayMessage = error ?? ""
                //Display local data if API Fails
                self.fetchLocalData()
                return
            }
            
            //Update DB content and reload Views
            DBDataObj.deleteAll()
            DBDataObj.addAll(apiObjList: data)
            self.fetchLocalData()
        }
    }
    
    private func fetchLocalData(){
        textData = DBDataObj.find(type: .text)
        imageData = DBDataObj.find(type: .image)
        
        tableView.reloadData()
        collectionView.reloadData()
    }
    
    
}

extension ListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if textData?.count == 0{
            tableView.setEmptyMessage(displayMessage)
        } else {
            tableView.removeEmptyMessage()
        }
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
        if imageData?.count == 0{
            collectionView.setEmptyMessage(displayMessage)
        } else {
            collectionView.removeEmptyMessage()
        }
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
    
    private func setupLoader(){
        activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    private func setupTableView(){
        tableView = UITableView(frame: .zero)
        tableView.backgroundColor = Color.backgroundColor
        
        tableView.register(DataCell.self, forCellReuseIdentifier: DataCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self

        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        self.view.addSubview(tableView)
    }
    
    private func setupCollectionView(){
        
        let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let columnLayout = ColumnFlowLayout(
            cellsPerRow: 2,
            minimumInteritemSpacing: 10,
            minimumLineSpacing: 10,
            sectionInset: sectionInsets,
            cellHeigtAspect: 1.1
        )
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: columnLayout)
        collectionView.backgroundColor = Color.backgroundColor
        collectionView.collectionViewLayout = columnLayout
        collectionView.alwaysBounceVertical = true
        
        collectionView.register(DataGridCell.self, forCellWithReuseIdentifier: DataGridCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
               
        self.view.addSubview(collectionView)
    }
    
    private func setupSegmentedControlView() {
        let segmentItems = ["Texts", "Images"]
        uisegmentedControl = UISegmentedControl(items: segmentItems)
        uisegmentedControl.frame = .zero
        uisegmentedControl.addTarget(self, action: #selector(segmentControl(_:)), for: .valueChanged)
        uisegmentedControl.selectedSegmentIndex = 0
        self.view.addSubview(uisegmentedControl)
    }
    
    private func applyUIConstraints(){
        uisegmentedControl.snp.makeConstraints {
            $0.left.equalToSuperview().offset(12)
            $0.right.equalToSuperview().offset(-12)
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(12)
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
    
    private func showTableView(){
        collectionView.isHidden = true
        tableView.isHidden = false
    }
    
    private func showCollectionView(){
        tableView.isHidden = true
        collectionView.isHidden = false
    }
    
}
