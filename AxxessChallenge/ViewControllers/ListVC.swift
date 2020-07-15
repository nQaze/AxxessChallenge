//
//  ListVC.swift
//  AxxessChallenge
//
//  Created by Nabil Kazi on 15/07/20.
//  Copyright © 2020 Nabil Kazi. All rights reserved.
//

import UIKit

class ListVC : UIViewController {
    
    private var apiDataController: APIDataController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiDataController = APIDataController()
        
        apiDataController.fetchData()
    }
    
}
