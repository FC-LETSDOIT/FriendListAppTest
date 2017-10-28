//
//  FriendListDB.swift
//  FriendListAppTest
//
//  Created by 滋野靖之 on 2017/09/24.
//  Copyright © 2017年 Alternated. All rights reserved.
//

import Foundation
import RealmSwift

//realmオブジェクトの定義(カラム名、主キーの設定)
class FriendObject: Object{
    @objc dynamic var id = Int()
    @objc dynamic var name = String()
    @objc dynamic var gender = String()
    @objc dynamic var other1 = String()
    @objc dynamic var other2 = String()
    @objc dynamic var image = NSData()
    
    override static func primaryKey() -> String?{
        return "id"
    }
}



//DBへアクセスするオブジェクト（クラス）の定義
class RealmBaseDao <T : RealmSwift.Object> {
    let realm: Realm
    init() {
        try! realm = Realm()
    }
    func newId() -> Int? {
        guard let key = T.primaryKey() else {
            return nil
        }        
        if let last = realm.objects(T.self).last,
            let lastId = last[key] as? Int {
            return lastId + 1
        } else {
            return 1
        }
    }
    //keyを与えて対応するオブジェクト(レコード)を取得する
    func find(key: AnyObject) -> T? {
        return realm.object(ofType: T.self, forPrimaryKey: key)
    }
    //全てのオブジェクト(レコード)を取得
    func findAll() -> Results<T> {
        return realm.objects(T.self)
    }
    //レコードを追加
    func add(d :T) {
        do {
            try realm.write {
                realm.add(d)
            }
        } catch let error as NSError {
            print(error.description)
        }
    }
    //特定のレコードを変更
    func update(d: T, block:(() -> Void)? = nil) -> Bool {
        do {
            try realm.write {
                block?()
                realm.add(d, update: true)
            }
            return true
        } catch let error as NSError {
            print(error.description)
        }
        return false
    }
    //特定のレコードを削除
    func delete(d: T) {
        do {
            try realm.write {
                realm.delete(d)
            }
        } catch let error as NSError {
            print(error.description)
        }
    }
    //全てのレコードを削除
    func deleteAll() {
        let objs = realm.objects(T.self)
        do {
            try realm.write {
                realm.delete(objs)
            }
        } catch let error as NSError {
            print(error.description)
        }
    }

}

