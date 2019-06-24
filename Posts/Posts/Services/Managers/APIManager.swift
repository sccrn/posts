//
//  APIManager.swift
//  Posts
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-06-19.
//  Copyright © 2019 Sam. All rights reserved.
//

import Alamofire
import RxSwift

class APIManager {
    private func createRequest<T:Decodable>(route: API) -> Observable<T> {
        return Observable<T>.create { observer in
           let request = AF.request(route).responseDecodable { (response: DataResponse<T>) in
                switch response.result {
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func fetchPosts() -> Single<[Post]> {
        return createRequest(route: API.posts).asSingle()
    }
    
    func fetchDetails(by post: PostModel) -> Single<PostModel> {
        let user = fetchUserDetails(by: post.userId)
        let comments = fetchComments(by: post.id)
        
        return Observable<PostModel>.create({ observer in
            Observable.zip(user, comments).subscribe(onNext: { userModel, commentsModel in
                post.userName = userModel.name
                post.numberOfComments = commentsModel.count
                observer.onNext(post)
                observer.onCompleted()
            }).dispose()
            return Disposables.create()
        }).asSingle()
    }
    
    private func fetchUserDetails(by userId: Int) -> Observable<User> {
        return createRequest(route: API.user(userId: userId))
    }
    
    private func fetchComments(by postId: Int) -> Observable<[Comments]> {
        return createRequest(route: API.comments(postId: postId))
    }
}
