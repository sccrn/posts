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

protocol PostDetailsDelegate: class {
    func didFinish(_ error: Error)
}

protocol PostDetailsCoordinatorDelegate: class {
    func moveToHomeScreen()
}

class PostDetailsViewModel {
    weak var delegate: PostDetailsDelegate?
    weak var coordinator: PostDetailsCoordinatorDelegate?
    
    private var model: PostModel
    private let disposeBag = DisposeBag()
    private lazy var postManager: PostManager = {
        let manager = PostManager()
        return manager
    }()
    
    private lazy var realmManager: RealmManager = {
        let manager = RealmManager()
        return manager
    }()
    
    var post = BehaviorRelay<PostModel>(value: PostModel())
    
    var postObservable: Observable<PostModel> {
        return post.asObservable()
    }
    
    init(coordinator: PostDetailsCoordinatorDelegate, post: PostModel) {
        self.coordinator = coordinator
        self.model = post
    }
    
    func setupPostDetails() {
        if Connectivity.isConnectedToInternet {
            model.hasDetails ? post.accept(model) : fetchDetails(postModel: model)
        } else {
            model.hasDetails ? post.accept(model) : delegate?.didFinish(PError.noConnection)
        }
    }
    
    //We're using the "zip" combining operator to get the result of these two requests.
    //Then we're getting the correct user and counting the comments in this post.
    //In this way, our home's screen only need to do one request.
    private func fetchDetails(postModel: PostModel) {
        Observable.zip(postManager.fetchUserDetails(), postManager.fetchComments(), resultSelector: { users, comments in
            if let user = users.first(where: { $0.id == postModel.userId }) {
                self.updatePost(response: postModel,
                                name: user.name, comments: comments.filter{$0.postId == postModel.id}.count)
            }
        }).observeOn(MainScheduler.instance)
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    private func updatePost(response: PostModel, name: String, comments: Int) {
        realmManager.editObject(name: name, comments: comments, obj: response)
        post.accept(response)
    }
}
