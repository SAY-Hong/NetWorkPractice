//
//  BestView.swift
//  NetworkPractice
//
//  Created by 홍세희 on 2023/11/21.
//

import SwiftUI

struct BestView: View {
    @State private var text = "URL 받아오기 전"
    @State private var users: [String] = []
    
    var body: some View {
        VStack(spacing: 100) {
            Text(text)
            Text(users.first ?? "받아오지 않음")
            
            Button {
                text = "URL 받아온 후"
                requestUser()
                
            } label: {
                Text("불러오기")
            }.buttonStyle(.bordered)

        }
    }
    private func requestUser() {
        NetworkManager.shared.requestUser(urlString: NetworkManager.shared.userAddress) { user, error in
            guard let user = user else {
                print("error")
                return
            }
            users.append(user.name)
        }
    }
}

#Preview {
    BestView()
}
