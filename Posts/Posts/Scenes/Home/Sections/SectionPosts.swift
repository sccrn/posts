//
//  SectionPosts.swift
//  Posts
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-06-22.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import UIKit
import RxDataSources

struct SectionPosts {
    var items: [PostModel]
    var header: String = ""
}

extension SectionPosts: SectionModelType {
    init(original: SectionPosts, items: [PostModel]) {
        self = original
        self.items = items
    }
}

extension SectionPosts: AnimatableSectionModelType {
    typealias Identity = String
    
    var identity: String {
        return header
    }
}
