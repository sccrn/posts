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
    private let disposeBag = DisposeBag()
    
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
    
    func fetchPosts() -> Single<[Post]> {
        return createRequest(route: API.posts).asSingle()
    }
    
    func fetchUserDetails(by userId: Int) -> Single<[User]> {
        return createRequest(route: API.user(userId: userId)).asSingle()
    }
    
    func fetchComments(by postId: Int) -> Single<[Comments]> {
        return createRequest(route: API.comments(postId: postId)).asSingle()
    }
}
