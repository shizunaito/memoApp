//
//  Task.swift
//  memoApp
//
//  Created by 伊藤静那(Ito Shizuna) on 2018/01/22.
//  Copyright © 2018年 ShizunaIto. All rights reserved.
//

import RealmSwift
import Foundation

class Task: Object {
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var detail = ""
    @objc dynamic var status = 0
    @objc dynamic var deadline: Date? = nil
    
    let tag = RealmOptional<Int>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override static func indexedProperties() -> [String] {
        return ["status"]
    }
    
    // TODO: 引数の渡し方がイマイチなので考えたい
    static func createOrUpdate(realm: Realm, with value: [String : Any]) -> Task {
        return realm.create(self, value: value, update: true)
    }
}
