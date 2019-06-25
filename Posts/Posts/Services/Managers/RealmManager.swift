//
//  RealmManager.swift
//  Posts
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-06-24.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import RealmSwift

///Our Realm's class with all the methods that we're gonna need, so we don't need to import in every
///class the RealmSwift. 
class RealmManager {
    let realm = try? Realm()

    ///Save array of objects to database
    func saveObjects(objs: [PostModel]) {
        try? realm!.write ({
            realm?.add(objs, update: false)
        })
    }
    
    /// Editing the object, that's why the update = true.
    func editObject(name: String, comments: Int, obj: PostModel) {
        try? realm!.write ({
            obj.hasDetails = true
            obj.userName = name
            obj.numberOfComments = comments
            realm?.add(obj, update: true)
        })
    }
    
    ///Returs an array as Results<object>?
    func getPostObjects() -> [PostModel] {
        let results = realm!.objects(PostModel.self)
        return results.compactMap { $0 }
    }
}
