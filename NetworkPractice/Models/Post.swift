//
//  Post.swift
//  NetworkPractice
//
//  Created by 홍세희 on 2023/11/21.
//

import Foundation
struct Post: Decodable {
    let id: Int
    let title, content, createdAt, updatedAt: String
    let userID: Int
    
    enum CodingKeys: String, CodingKey {
        case id, title, content, createdAt, updatedAt
        case userID = "UserId"
    }
}
