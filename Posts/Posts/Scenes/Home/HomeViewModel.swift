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
import RealmSwift

protocol HomeCoordinatorDelegate: class {
    func moveToDetailsScreen(_ controller: HomeController, didSelectPost model: PostModel)
}

enum HomeAction {
    case alertError(err: Error)
    case seeDetails(post: PostModel)
}

protocol HomeDelegate: class {
    func didFinish(_ action: HomeAction)
}

class HomeViewModel {
    weak var delegate: HomeDelegate?
    weak var coordinator: HomeCoordinatorDelegate?
    
    private let realmManager = RealmManager()
    private let apiManager = APIManager()
    private let disposeBag = DisposeBag()
    private var postsModel: [PostModel] = []
    
    var posts = BehaviorRelay<[PostModel]>(value: [])
    
    var postObservable: Observable<[PostModel]> {
        return posts.asObservable()
    }
    
    func setupPosts() {
        postsModel = realmManager.getPostObjects()

        if postsModel.count == 0 {
            loadPosts()
        } else {
            posts.accept(postsModel)
        }
    }

    private func loadPosts() {
        apiManager.fetchPosts().subscribe(onSuccess: { [weak self] (posts) in
            self?.savePosts(response: posts)
            }, onError: { error in
                self.delegate?.didFinish(.alertError(err: error))
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
}

extension HomeViewModel {
    func numberOfPosts() -> Int { return posts.value.count }
    
    func postName(for row: Int) -> String { return posts.value[row].title }
    
    func postSelected(for row: Int) -> PostModel { return posts.value[row] }
}
