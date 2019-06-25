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

protocol HomeCoordinatorDelegate: class {
    func moveToDetailsScreen(_ postSelected: PostModel)
}

protocol HomeDelegate: class {
    func didFinish(_ error: Error)
}

class HomeViewModel {
    weak var delegate: HomeDelegate?
    weak var coordinator: HomeCoordinatorDelegate?
    
    private let realmManager = RealmManager()
    private let disposeBag = DisposeBag()
    private var postsModel: [PostModel] = []
    
    private lazy var postManager: PostManager = {
        let manager = PostManager()
        return manager
    }()

    var posts = BehaviorRelay<[PostModel]>(value: [])
    
    var postObservable: Observable<[PostModel]> {
        return posts.asObservable()
    }
    
    func setupPosts() {
        postsModel.removeAll()
        postsModel = realmManager.getPostObjects()
        
        if Connectivity.isConnectedToInternet {
            postsModel.count == 0 ? loadPosts() : posts.accept(postsModel)
        } else {
           postsModel.count == 0 ? delegate?.didFinish(PError.noConnection) : posts.accept(postsModel)
        }
    }

    func loadPosts() {
        postManager.fetchPosts().subscribe(onSuccess: { [weak self] (posts) in
            self?.savePosts(response: posts)
            }, onError: { error in
                self.delegate?.didFinish(error)
        }).disposed(by: disposeBag)
    }
    
    private func savePosts(response: [Post]) {
        var array: [PostModel] = []
        
        for post in response {
            let model = PostModel()
            model.id = post.id
            model.body = post.body
            model.userId = post.userId
            model.title = post.title
            
            array.append(model)
        }
        realmManager.saveObjects(objs: array)
        posts.accept(array)
    }
    
    func postSelected(for row: Int) -> PostModel { return posts.value[row] }
}
