//
//  Networking.swift
//  Combine_Test
//
//  Created by 정지훈 on 2022/06/24.
//

import Foundation
import Alamofire

enum Networking {
    case login(email: String, password: String)
    case users
    case randomUsers(page: String, results: String)
}

extension Networking : TargetType {
    
    var baseURL: String {
        return BuildConfig.setAppState.baseURL
    }
    
    var version: String {
        return BuildConfig.setAppState.version
    }
    
    var path: RequestType {
        switch self {
        case .login:
            return .requestPath(path: "/api/login")
        case .users:
            return .requestPath(path: "/api/users")
        case .randomUsers:
            return .requestPath(path: "/api")
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .users, .randomUsers:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .login(let email, let password):
            return .requestParameters(parameters: ["email": email, "password" : password], encoding:JSONEncoding.default)
        case .users:
            return .requestPlain
        case .randomUsers(let page, let results):
            return .requestParameters(parameters: ["page": page, "results": results], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default :
            return ["Content-Type":"application/json"]
        }
    }
}
