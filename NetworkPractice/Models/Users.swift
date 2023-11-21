//
//  Users.swift
//  NetworkPractice
//
//  Created by 홍세희 on 2023/11/21.
//

import Foundation

struct User: Decodable { //서버에 요청을 해서 받아올거기 때문에 Decodable이 필요할거라고 생각되므로..
    let id: Int
    let name, username, email, phone: String
    let website, province, city, district, street, zipcode: String
    let createdAt, updatedAt: String
    //근데 왜 이렇게 다 따로따로 놓은걸까 -> 그냥 보기 좋게?
}


//"id": 1,
//       "name": "이정도",
//       "username": "jd1386",
//       "email": "lee.jungdo@gmail.com",
//       "phone": "010-3192-2910",
//       "website": "https://leejungdo.com",
//       "province": "경기도",
//       "city": "성남시",
//       "district": "분당구",
//       "street": "대왕판교로 160",
//       "zipcode": "13525",
//       "createdAt": "2019-02-24T16:17:47.000Z",
//       "updatedAt": "2019-02-24T16:17:47.000Z"

