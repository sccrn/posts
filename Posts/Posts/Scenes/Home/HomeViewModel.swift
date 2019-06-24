//
//  HomeViewModel.swift
//  Posts
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-06-20.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol HomeDelegate: class {
    func didFail(err: Error)
}

class HomeViewModel {
    weak var delegate: HomeDelegate?
    private let disposeBag = DisposeBag()
    var posts = BehaviorRelay<[Post]>(value: [])

    func loadPosts() {
        APIManager.fetchPosts().subscribe(onSuccess: { [weak self] (posts) in
                self?.posts.accept(posts)
            }, onError: { error in
                self.delegate?.didFail(err: error)
        }).disposed(by: disposeBag)
    }
}

extension HomeViewModel {
    func numberOfPosts() -> Int { return posts.value.count }
    
    func postName(for row: Int) -> String { return posts.value[row].title }
    
    func postSelected(for row: Int) -> Post { return posts.value[row] }
}
