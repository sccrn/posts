//
//  PostManager.swift
//  Posts
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-06-19.
//  Copyright © 2019 Sam. All rights reserved.
//

import Alamofire
import RxSwift

///Our manager that contains all the methods that we're gonna need for make the requests.
class PostManager {
    ///Our generic method to make the request.
    private func createRequest<T:Codable>(route: API) -> Observable<T> {
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
    
    ///Get all the posts.
    func fetchPosts() -> Single<[Post]> {
        return createRequest(route: API.posts).asSingle()
    }
    
    ///Get all the users.
    func fetchUserDetails() -> Observable<[User]> {
        return createRequest(route: API.user)
    }
    
    ///Get all the comments.
    func fetchComments() -> Observable<[Comments]> {
        return createRequest(route: API.comments)
    }
}
