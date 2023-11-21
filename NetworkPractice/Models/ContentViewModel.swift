//
//  ContentViewModel.swift
//  NetworkPractice
//
//  Created by 홍세희 on 2023/11/21.
//

import Foundation

class ContentViewModel: ObservableObject { //ObservableObject 채택하기.
    //@Published -> 바뀌면 신호를 준다.
    @Published var posts: [String] = ["hi", "say", "hee"]
    @Published var users: [String] = ["user1", "user2"]
    
    func requestPost() {
        NetworkManager.shared.requestURL(urlString: NetworkManager.shared.postAddress) { [self] Post, error in
            guard let Post = Post else {
                print("error")
                return
            }
            self.posts.append(Post.title)
        }
    }
    
    func requestUser() {
        NetworkManager.shared.requestUser(urlString: NetworkManager.shared.userAddress) { user, error in
            guard let user = user else {
                print("error")
                return
            }
            self.users.append(user.name)
        }
    }
}
