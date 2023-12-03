//
//  ContentViewModel.swift
//  NetworkPractice
//
//  Created by 홍세희 on 2023/11/21.
//

import Foundation

//에러를 정의해ㅐㅆ는데 발생하는 곳을 만들 수 없다면... 의심
//분명 에러를 발생시켰는데 처리하는 부분이 없다..? 버그
//명확하게 잘못된 케이스를 처리할 수 있게 하기

//우리는 에러를 정의했고
//에러를 써서 보내서 에러를 처리할 수 있게했다.
//에러 정의 - 보내기 - 받아서 처리하기 -> 하는 과정이 다 있다면 굉장히 좋은 습관!
//로직에서 발생할 수 있는 실패사항이 있을 수 밖에 없다. -> 잘 처리해야 매끄럽게 사용 가능하다.

class ContentViewModel: ObservableObject { //ObservableObject 채택하기.
    //@Published -> 바뀌면 신호를 준다.
    @Published var posts: [String] = ["hi", "say", "hee"]
    @Published var users: [String] = ["user1", "user2"]
    
    func requestPost() {
        NetworkManager.shared.requestPost(urlString: NetworkManager.shared.postAddress) { post, error in
            
            if error == "This is not correct url" {
                // url이 유효하지 않은 alert 띄워주기
            } else if error == "We got some error. check the internet." {
                //인터넷 상태가 유효하지 않은 alert 띄워주기
            } else if error == "Invaild response"{
                
            }
            guard let post = post else {
                print(error)
                return
            }
            self.posts.append(post.title)
        }
    }
    
    func requestUser() {
        NetworkManager.shared.requestUser(urlString: NetworkManager.shared.userAddress) { user, error in
            
            switch error {
                
            case .invalidURL:
                print()
            case .badConnection:
                print()
            case .invalidResponse:
                print()
            case .invalidData:
                print()
            default:
                print()
                
            }
            guard let user = user else {
                print("error")
                return
            }
            self.users.append(user.name)
        }
    }
}
