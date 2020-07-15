//
//  APIDataController.swift
//  AxxessChallenge
//
//  Created by Nabil Kazi on 15/07/20.
//  Copyright © 2020 Nabil Kazi. All rights reserved.
//

import Foundation
import Alamofire

class APIDataController {
    
    func fetchData() {
        let request = AF.request(Constants.apiURL)

        request.responseDecodable(of: APIModelList.self) { (response) in
          guard let response = response.value else { return }
            DBDataObj.deleteAll()
            let dbObjects = DBDataObj.addAll(apiObjList: response)
            print(dbObjects)
        }
    }

}
