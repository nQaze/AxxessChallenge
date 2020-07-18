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
    
    func fetchData(completion: @escaping (_ response: APIModelList?, _ error: String?) -> Void) {
        let request = AF.request(Constants.apiURL)

        request.responseDecodable(of: APIModelList.self) { (response) in
            guard let data = response.value else {
                completion(nil, response.error?.localizedDescription)
                return
            }
            completion(data, nil)
        }
    }

}
