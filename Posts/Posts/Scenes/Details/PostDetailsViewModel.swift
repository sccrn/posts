//
//  PostDetailsViewModel.swift
//  Posts
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-06-24.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

class PostDetailsViewModel {
    var post = BehaviorRelay<PostModel>(value: PostModel())
    private let disposeBag = DisposeBag()
}
