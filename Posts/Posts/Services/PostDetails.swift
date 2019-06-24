//
//  PostDetails.swift
//  Posts
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-06-22.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation

class PostDetails {
    var user: String
    var description: String
    var numberOfComments: Int
    
    init(user: String, description: String, numberOfComments: Int) {
        self.user = user
        self.description = description
        self.numberOfComments = numberOfComments
    }
}
