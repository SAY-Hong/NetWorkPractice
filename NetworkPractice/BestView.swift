//
//  BestView.swift
//  NetworkPractice
//
//  Created by 홍세희 on 2023/11/21.
//

import SwiftUI

struct BestView: View {
    @State private var text = "URL 받아오기 전"
    @Binding var posts: [String]
    var body: some View {
        VStack(spacing: 100) {
            Text(text)
            ForEach(posts, id: \.self) { item in
                Text(item)
            }
            
            Button {
                text = "URL 받아온 후"
                ContentView().requestPost()
            } label: {
                Text("불러오기")
            }.buttonStyle(.bordered)

        }
    }
//    func requestPost() {
//        requestURL(urlString: postAddress) { Post, error in
//            
//            guard let Post = Post else {
//                print("error")
//                return
//            }
//            posts.append(Post.title)
//        }
//    }
}

//#Preview {
//    BestView()
//}
