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
    
    var post = BehaviorRelay<PostModel>(value: PostModel())
    private let disposeBag = DisposeBag()
    private lazy var postManager: APIManager = {
        let manager = APIManager()
        return manager
    }()
    
    private lazy var realmManager: RealmManager = {
        let manager = RealmManager()
        return manager
    }()
    
    var postObservable: Observable<PostModel> {
        return post.asObservable()
    }
    
    init(coordinator: PostDetailsCoordinatorDelegate, post: PostModel) {
        self.coordinator = coordinator
        setupPostDetails(post: post)
    }
    
    private func setupPostDetails(post: PostModel) {
        if post.userName.isEmpty {
            fetchDetails(post: post)
        } else {
            self.post.accept(post)
        }
    }
    
    private func fetchDetails(post: PostModel) {
//        Observable.zip(postManager.fetchUserDetails(by: post.userId), postManager.fetchComments(by: post.id)) { users, comments in
//            return (users, comments)
//            }.subscribe(onNext: { users, comments in
//                var array = users.filter { $0.id == post.userId }
//                post.userName = array[0].name
//                post.numberOfComments = comments.count
//
//                self.updatePost(response: post)
//            }, onError: { error in
//                self.delegate?.didFinish(error)
//            }).disposed(by: disposeBag)
        postManager.fetchComments(by: post.id).subscribe(onSuccess: { [weak self] (comments) in
                print("aaaa ", comments.count)
            }, onError: { error in
                self.delegate?.didFinish(error)
        }).disposed(by: disposeBag)
    }
    
    private func updatePost(response: PostModel) {
        realmManager.editObject(obj: response)
        post.accept(response)
    }
}
