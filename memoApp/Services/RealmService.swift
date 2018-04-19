//
//  RealmService.swift
//  memoApp
//
//  Created by 伊藤静那(Ito Shizuna) on 2018/03/28.
//  Copyright © 2018年 ShizunaIto. All rights reserved.
//

import RxSwift
import RxCocoa
import RealmSwift

protocol RealmServiceType {
    func saveTask(title: String)
}

final class RealmService: RealmServiceType {
    
    var disposeBag = DisposeBag()
    let realm = try! Realm()

    private func setNextId() -> Int {
        let lastId = realm.objects(Task.self).last?.id ?? -1
        return lastId + 1
    }

    func saveTask(title: String) {
        let value: [String : Any] = [
            "id" : setNextId(),
            "title" : title,
            "detail" : "",
            "status" : 0
        ]

        try! realm.write {
            realm.create(Task.self, value: value, update: true)
        }
    }
}
