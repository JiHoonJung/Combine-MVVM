//
//  RandomUserRequest.swift
//  Combine_Test
//
//  Created by 정지훈 on 2022/06/27.
//

import Foundation
import Combine

protocol RandomUserProtocol {
    func getRandomUserData(page: String, results: String) -> AnyPublisher<RandomUserResponse?, APIError>
}

class RandomUserReqeust: BaseAPI<Networking>, RandomUserProtocol {
    
    func getRandomUserData(page: String, results: String) -> AnyPublisher<RandomUserResponse?, APIError> {
        self.fetchData(target: .randomUsers(page: page, results: results), responseClass: RandomUserResponse.self)
    }
    
}
//
//protocol LoginServiceProtocol : AnyObject {
//    func loginService(email : String, password : String) -> AnyPublisher <LoginResponse?, APIError>
//}
//
//class LoginRequest : BaseAPI<Networking>, LoginServiceProtocol {
//    
//    func loginService(email : String, password : String) -> AnyPublisher<LoginResponse?, APIError> {
//        self.fetchData(target: .login(email: email, password: password), responseClass: LoginResponse.self)
//    }
//}
//
//struct LoginResponse : Decodable {
//    var token : String?
//}
