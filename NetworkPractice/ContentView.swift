//
//  ContentView.swift
//  NetworkPractice
//
//  Created by 홍세희 on 2023/11/15.
//

/*가장 밑바닥부터 배우자!!!
 
 */
import SwiftUI

///1. 서버에 데이터를 요청한다
///
///
///2. 데이터를 받아온다. (JSON
///3. 데이터를 파싱한다.
///4. 파싱한 데이터로 화면을 그린다.
///
///
///데이터를 해석할 수 있는 틀이 필요하다.
///
///
///https://koreanjson.com/users
struct Post: Decodable {
    let id: Int
    let title, content, createdAt, updatedAt: String
    let userID: Int
    
    enum CodingKeys: String, CodingKey {
        case id, title, content, createdAt, updatedAt
        case userID = "UserId"
    }
}

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

struct ContentView: View {
    @State var posts: [String] = ["hi", "say", "hee"]
    @State var users: [String] = ["user1", "user2"]
    var body: some View {
        VStack {
            List {
                ForEach(posts, id: \.self) { item in
                    Text(item)
                }
                
                ForEach(users, id: \.self) { item in
                    Text(item)
                }
            }
            //MARK: Request Button 1
            Button {
                requestData()
            } label: {
                Text("Request Post")
            }
            
            //MARK: Request Button 2
            Button {
                requestUser()
            } label: {
                Text("Request User")
            }
        }
    }
    
    private func requestData() {
        requestArticle { article, error in
            
            guard let article = article else {
                print("error")
                return
            }
            
            posts.append(article.title)
        }
    }
    
    private func requestUser() {
        requestArticle { article, error in
            
            guard let article = article else {
                print("error")
                return
            }
            
            posts.append(article.title)
        }
    }
    
    //MARK: 04 another request 영상부터 다시 보기
    func requestArticle(completion: @escaping (Post?, String?) -> ()) {
        //어디에 요청을 할 것인가?
        let endPoint = "https://koreanjson.com/posts/1"
        
        //위에가 url인지 검증하기
        guard let url = URL(string: endPoint) else {
            completion(nil, "This is not correct url")
            return
        }
        
        /* <URLSession>
         - 특정 url을 이용하여 데이터를 다운로드하고 업로드하기 위한 API
         - 앱에서 서버와 통신하기 위한 API
         */
        
//        //URLRequest 설정
//        var request: URLRequest = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        
//        //URLSession 생성(기본 세션)
//        let session: URLSession = URLSession(configuration: .default)
//        
//        session.dataTask(with: request) { data, response, error in
//            if let _ = error {
//                completion(nil, "We got some error. check the internet.")
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                completion(nil, "Invaild response")
//                return
//            }
//            
//            guard let data = data else {
//                completion(nil, "The data recived is wrong.")
//                return
//            }
//            
//            do {
//                let decodedResponse = try JSONDecoder().decode(Post.self, from: data)
//                completion(decodedResponse, nil)
//            } catch {
//                print(error)
//            }
//        }.resume()
        
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
}

#Preview {
    ContentView()
}

