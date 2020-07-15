//
//  DBDataObj.swift
//  AxxessChallenge
//
//  Created by Nabil Kazi on 15/07/20.
//  Copyright © 2020 Nabil Kazi. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class DBDataObj: Object {
    
    enum Property: String {
        case id, type, date, data
    }
    
    dynamic var id:  String! = ""
    dynamic var date: String? = ""
    dynamic var data: String? = ""
    dynamic var type: TypeEnum = .text
    
    override static func primaryKey() -> String? {
        return DBDataObj.Property.id.rawValue
    }
    
    convenience init(_ apiObject: APIModel) {
        self.init()
        self.id = apiObject.id
        self.type = apiObject.type
        self.date = apiObject.date
        self.data = apiObject.data
    }
}

extension DBDataObj {
    static func all(in realm: Realm = try! Realm()) -> Results<DBDataObj> {
        return realm.objects(DBDataObj.self)
    }

    static func find(id: String, in realm: Realm = try! Realm()) -> Results<DBDataObj> {
        return realm.objects(DBDataObj.self).filter("id = '\(id)'")
    }

    @discardableResult
    static func addAll(apiObjList: APIModelList, in realm: Realm = try! Realm())
        -> List<DBDataObj> {
            
            let allObjects = List<DBDataObj>()
            for apiObject in apiObjList{
                allObjects.append(DBDataObj(apiObject))
            }
            
            try! realm.write {
                realm.add(allObjects, update: .all)
            }
            
            return allObjects
    }
    
    static func deleteAll(in realm: Realm = try! Realm()) {
        try! realm.write {
            let allObjects = realm.objects(DBDataObj.self)
            realm.delete(allObjects)
        }
    }
    
}
