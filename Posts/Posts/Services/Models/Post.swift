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
    let id: Int?
    let name: String?
    let username: String?
    let email: String?
    let address: Address
    let phone: String?
    let website: String?
    let company: Company
    
}

struct Address: Codable {
    let street: String?
    let suite: String?
    let city: String?
    let zipcode: String?
    let geo: Geo
}

struct Geo: Codable {
    let lat: String?
    let lng: String?
}

struct Company: Codable {
    let name: String?
    let catchPhrase: String?
    let bs: String?
}

struct Comments: Codable {
    let id: Int?
    let name: String?
    let email: String?
    let postId: Int?
    let body: String?
}
