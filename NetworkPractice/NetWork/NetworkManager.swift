//
//  NetworkManager.swift
//  NetworkPractice
//
//  Created by 홍세희 on 2023/11/21.
//

//MARK: 싱글턴
// 노션 정리 완

import Foundation

enum NetworkError {
    case invalidURL
    case badConnection
    case invalidResponse
    case invalidData
    
    var errorMessage: String {
        switch self {
        case .invalidURL:
            return "This is not correct url"
        case .badConnection:
            return "We got some error. check the internet."
        case .invalidResponse:
            return "Invaild response"
        case .invalidData:
            return "The data recived is wrong."
        }
    }
}

final class NetworkManager { //MARK: final 키워드 굳이 사용한 이유?
    static let shared = NetworkManager()
    
    private init() {}
    
    var userAddress: String = "https://koreanjson.com/users/1"
    var postAddress: String = "https://koreanjson.com/posts/1"

    func requestPost(urlString: String, completion: @escaping (Post?, String?) -> ()) {
        //어디에 요청을 할 것인가?
        //        let urlString = "https://koreanjson.com/posts/1"
        
        //위에가 url인지 검증하기
        guard let url = URL(string: urlString) else {
            completion(nil,  "This is not correct url")
            return
        }
        
        /* <URLSession>
         - 특정 url을 이용하여 데이터를 다운로드하고 업로드하기 위한 API
         - 앱에서 서버와 통신하기 위한 API
         */
        
        //URLSession 생성(기본 세션)
        //dataTask
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(nil, "We got some error. check the internet.")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil, "Invaild response")
                return
            }
            
            guard let data = data else {
                completion(nil, "The data recived is wrong.")
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(Post.self, from: data)
                //data.append(decodedResponse.title)
                completion(decodedResponse, nil)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func requestUser(urlString: String, completion: @escaping (User?, NetworkError?) -> ()) {
        //어디에 요청을 할 것인가?
//        let urlString = "https://koreanjson.com/posts/1"
        
        //위에가 url인지 검증하기
        guard let url = URL(string: urlString) else {
            completion(nil, .invalidURL)
            return
        }
        
        //URLSession 생성(기본 세션)
        //dataTask
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(nil, .badConnection)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil, .invalidResponse)
                return
            }
            
            guard let data = data else {
                completion(nil, .invalidData)
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(User.self, from: data)
                //data.append(decodedResponse.title)
                completion(decodedResponse, nil)
            } catch {
                print(error)
            }
        }.resume()
    }
 }
