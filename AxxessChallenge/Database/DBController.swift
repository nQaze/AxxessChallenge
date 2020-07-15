//
//  DBController.swift
//  AxxessChallenge
//
//  Created by Nabil Kazi on 15/07/20.
//  Copyright © 2020 Nabil Kazi. All rights reserved.
//

import Foundation
import RealmSwift

class DBController{
    
    public static var shareInstance = DBController()
    
    static let currentSchemaVersion: UInt64 = 0
    
    static func deleteDB(){
        let realm = try! Realm()
        
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    static func configureMigration() {
        let config = Realm.Configuration(schemaVersion: currentSchemaVersion, migrationBlock: { (migration, oldSchemaVersion) in
            
            //Migration Logic Here
            
        })
        Realm.Configuration.defaultConfiguration = config
    }
    
}
