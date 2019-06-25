//
//  PostModel.swift
//  Posts
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-06-24.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import RealmSwift
import RxDataSources


///Our Realm's model for our post's object.
class PostModel: Object {
    @objc dynamic var userId: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var body: String = ""
    @objc dynamic var userName: String = ""
    @objc dynamic var numberOfComments: Int = 0
    @objc dynamic var hasDetails: Bool = false
    
    override static func primaryKey() -> String {
        return "id"
    }
}

///This is our identifier to each object.
extension PostModel: IdentifiableType {
    typealias Identity = String
    
    var identity: String {
        return "\(id)"
    }
}
