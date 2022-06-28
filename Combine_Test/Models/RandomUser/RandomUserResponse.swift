//
//  RandomUserResponse.swift
//  Combine_Test
//
//  Created by 정지훈 on 2022/06/23.
//

import Foundation

struct RandomUserResponse: Codable {
    let results: [RandomUser]
    let info: Info
}

struct RandomUser: Codable, Identifiable {
    let id = UUID()
    let name: Name
    let photo: Photo
    let gender: String
    let email: String
    let phone: String
    let cell: String
    
    private enum CodingKeys: String, CodingKey {
        case name, gender, email, phone, cell
        case photo = "picture"
    }
}

struct Name: Codable {
    let title: String
    let first: String
    let last: String
}

struct Photo: Codable {
    let large: String
    let medium: String
    let thumbnail: String
}

struct Info: Codable {
    let seed: String
    let resultCount: Int
    let page: Int
    let version: String
    
    private enum CodingKeys: String, CodingKey {
        case seed, page, version
        case resultCount = "results"
    }
}
