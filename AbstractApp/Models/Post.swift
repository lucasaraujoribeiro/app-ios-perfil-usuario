//
//  Post.swift
//  Abstract
//
//  Created by Silvano Maneck Malfatti on 31/03/25.
//

import Foundation

struct Post: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

/*enum PostKey: String {
    case userId = "user_id"
    case id = "id"
    case title = "title"
    case body = "body"
}

// Struct Post com Decodable
struct Post: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case id
        case title
        case body
    }
}*/
