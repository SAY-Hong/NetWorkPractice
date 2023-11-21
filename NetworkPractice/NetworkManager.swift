//
//  NetworkManager.swift
//  NetworkPractice
//
//  Created by 홍세희 on 2023/11/21.
//

import Foundation

class NetworkManager { //싱글턴?
    static let shared = NetworkManager()
    
    private init() {}

    func requestURL(urlString: String, completion: @escaping (Post?, String?) -> ()) {
        //어디에 요청을 할 것인가?
        //        let urlString = "https://koreanjson.com/posts/1"
        
        //위에가 url인지 검증하기
        guard let url = URL(string: urlString) else {
            completion(nil, "This is not correct url")
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
    
    func requestUser(urlString: String, completion: @escaping (User?, String?) -> ()) {
        //어디에 요청을 할 것인가?
//        let urlString = "https://koreanjson.com/posts/1"
        
        //위에가 url인지 검증하기
        guard let url = URL(string: urlString) else {
            completion(nil, "This is not correct url")
            return
        }
        
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
                let decodedResponse = try JSONDecoder().decode(User.self, from: data)
                //data.append(decodedResponse.title)
                completion(decodedResponse, nil)
            } catch {
                print(error)
            }
        }.resume()
    }
 }
