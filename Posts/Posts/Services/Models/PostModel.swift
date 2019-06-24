//
//  PostModel.swift
//  Posts
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-06-24.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import RealmSwift

class PostModel: Object {
    @objc dynamic var userId: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var body: String = ""
    @objc dynamic var userName: String = ""
    @objc dynamic var numberOfComments: Int = 0
    
    override static func primaryKey() -> String {
        return "id"
    }
}
