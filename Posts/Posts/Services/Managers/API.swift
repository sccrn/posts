//
//  API.swift
//  Posts
//
//  Created by Samanta Clara Coutinho Rondon do Nascimento on 2019-06-20.
//  Copyright © 2019 Sam. All rights reserved.
//

import Foundation
import Alamofire

///This is the enum that we're gonna use to not repeat code in our requests.
enum API: URLRequestConvertible {
    case posts
    case user
    case comments
    
    private var method: HTTPMethod {
        return .get
    }
    
    private var path: String {
        switch self {
        case .posts: return Constants.posts
        case .user: return Constants.users
        case .comments: return Constants.comments
        }
    }
    
    ///Here, we will get from this function our urlRequest exactly the type that we need.
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.setValue(Constants.json, forHTTPHeaderField: Constants.acceptType)
        urlRequest.setValue(Constants.json, forHTTPHeaderField: Constants.contentType)

        return urlRequest
    }
}
