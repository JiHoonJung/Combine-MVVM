//
//  CoreAPIEnums.swift
//  Combine_Test
//
//  Created by 정지훈 on 2022/06/24.
//

import Foundation

enum BaseURLType {
    case baseApi
    case getMedia
    
    var desc : String {
        switch self {
        case .baseApi:
            return "https://randomuser.me"
        case .getMedia:
            return "https://reqres.in/"
        }
    }
}

enum VersionType {
    case empty
    case v1, v2
    
    var desc : String {
        switch self {
        case .empty:
            return ""
        case .v1:
            return "/v1"
        case .v2:
            return "/v2"
        }
    }
}

enum APIError: Error {
    case general
    case timeout
    case pageNotFound
    case noData
    case noNetwork
    case unknownError
    case serverError
    case statusMessage(message: String)
    case decodeError(String)
}

extension APIError {
    ///description of error
    var desc: String {
        
        switch self {
        case .general:                    return MessageHelper.serverError.general
        case .timeout:                    return MessageHelper.serverError.timeOut
        case .pageNotFound:               return MessageHelper.serverError.notFound
        case .noData:                     return MessageHelper.serverError.notFound
        case .noNetwork:                  return MessageHelper.serverError.noInternet
        case .unknownError:               return MessageHelper.serverError.general
        case .serverError:                return MessageHelper.serverError.serverError
        case .statusMessage(let message): return message
        case .decodeError(let error):     return error
        }
    }
}

struct MessageHelper {
    
    /// General Message Handler
    struct serverError {
        static let general : String = "Bad Request"
        static let noInternet : String = "Check the Connection"
        static let timeOut : String = "Timeout"
        static let notFound : String = "No Result"
        static let serverError : String = "Internal Server Error"
    }
}

