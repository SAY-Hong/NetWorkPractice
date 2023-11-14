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
struct Article: Decodable {
    let id: Int
    let title, content, createdAt, updatedAt: String
    let userID: Int
    
    enum CodingKeys: String, CodingKey {
        case id, title, content, createdAt, updatedAt
        case userID = "UserId"
    }
}

struct ContentView: View {
    @State var data: [String] = ["hi", "say", "hee"]
    var body: some View {
        VStack {
            List {
                ForEach(data, id: \.self) { item in
                    Text(item)
                }
            }
            Button {
                requestData()
                
            } label: {
                Text("Request")
            }
        }
    }
    private func requestData() {
        requestArticle { article, error in
            
            guard let article = article else {
                print("error")
                return
            }
            
            data.append(article.title)
        }
    }
    
    func requestArticle(completed: @escaping (Article?, String?) -> ()) {
        //어디에 요청을 할 것인가?
        let endPoint = "https://koreanjson.com/posts/1"
        
        //위에가 url인지 검증하기
        guard let url = URL(string: endPoint) else {
            completed(nil, "This is not correct url")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(nil, "We got some error. check the internet.")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, "Invaild response")
                return
            }
            
            guard let data = data else {
                completed(nil, "The data recived is wrong.")
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(Article.self, from: data)
                //data.append(decodedResponse.title)
                completed(decodedResponse, nil)
            } catch {
                print(error)
            }
        }.resume()
    }
}

#Preview {
    ContentView()
}

