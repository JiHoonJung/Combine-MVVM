//
//  CoreAPI.swift
//  Combine_Test
//
//  Created by 정지훈 on 2022/06/24.
//

import Foundation
import Alamofire
import Combine

class BaseAPI<T: TargetType> {
    
    typealias AnyPublisherResult<M> = AnyPublisher<M?, APIError>
    typealias FutureResult<M> = Future<M?, APIError>
    
    let session = Session(eventMonitors: [AlamofireLogger()])
    
    /// ```
    /// Generic Base Class + Combine Concept + Future Promise
    ///
    /// ```
    ///
    /// - Returns: `etc promise(.failure(.timeout)) || promise(.success(value))`.
    ///
    
    func fetchData<M: Decodable>(target: T, responseClass: M.Type) -> AnyPublisherResult<M> {
        
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let params = buildParameters(task: target.task)
        let targetPath = buildTarget(target: target.path)
        let url = (target.baseURL + target.version + targetPath)
        
        return FutureResult<M> { [weak self] promise in
            
            self?.session.request(url, method: method, parameters: params.0, encoding: params.1, headers: headers, requestModifier: { $0.timeoutInterval = 20 })
                .validate(statusCode: 200..<300)
                .responseDecodable(of: M.self) { response in
                    
                    switch response.result {
                        
                    case .success(let value):
                        
                        promise(.success(value))
                        
                    case .failure(let error):
                        guard !error.isTimeout else {return promise(.failure(.timeout)) }
                        guard !error.isConnectedToTheInternet else { return promise(.failure(.noNetwork)) }
                        return promise(.failure(.general))
                    }
                }
        }
        .eraseToAnyPublisher()
    }
}

extension BaseAPI {

    func buildParameters(task: Task) -> ([String:Any], ParameterEncoding) {
        switch task {
        case .requestPlain:
            return ([:], URLEncoding.default)
        case .requestParameters(parameters: let parameters, encoding: let encoding):
            return (parameters, encoding)
        }
    }
    
    func buildTarget(target: RequestType) -> String {
        switch target {
        case .requestPath(path: let path):
            return path
        case .queryParametrs(query: let query):
            return query
        }
    }
}

extension AFError {
    
    var isTimeout: Bool {
        if isSessionTaskError,
           let error = underlyingError as NSError?,
           error.code == NSURLErrorTimedOut || error.code == NSURLErrorUnknown {
            return true
        }
        return false
    }
    
    var isConnectedToTheInternet: Bool {
        if isSessionTaskError,
           let error = underlyingError as NSError?,
           error.code == NSURLErrorNotConnectedToInternet || error.code == NSURLErrorDataNotAllowed {
            return true
        }
        return false
    }
}
