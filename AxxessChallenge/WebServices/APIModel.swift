//
//  APIObject.swift
//  AxxessChallenge
//
//  Created by Nabil Kazi on 15/07/20.
//  Copyright © 2020 Nabil Kazi. All rights reserved.
//

import Foundation

struct APIModel: Codable {
    let id: String
    let type: TypeEnum
    let date: String?
    let data: String?
}

enum TypeEnum: String, Codable {
    case image = "image"
    case other = "other"
    case text = "text"
}

typealias APIModelList = [APIModel]
