//
//  Post.swift
//  Posts
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-06-20.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

struct User: Codable {
    let id: Int
    let name: String
}

struct Comments: Codable {
    let postId: Int
    let id: Int
    let name: String
}
