//
//  FunctionTest.swift
//  NetworkPractice
//
//  Created by 홍세희 on 2023/11/15.
//

import SwiftUI

struct FunctionTest: View {
    var sayHi: (String) -> () = { name in
        print("Hi \(name)")
    }
    var body: some View {
        VStack {
            Text("")
            Button {
                //sayHi("hihee2")
//                sayHello(name: "HiHee") {
//                    print("good night!")
//                }
                sayHello(with: "url") { data, response, error in
                    print("\(data), \(response), \(error)")
                }
            } label: {
                Text("Touch")
            }
        }
    }
    func requestArticle(completed: @escaping (Post?, String?) -> ()) {
        sayHello(with: "url") { data, response, error in
            if error == "error" {
                completed(nil, "error")
            }
            if response != "response" {
                completed(nil, "errorResponse")
            }
            if data == "data" {
                //디코더가 우리의 데이터틀 article로 바꿔준다.
            }
        }
    }
    func sayHello(with name: String, action: (String, String, String) -> ()) {
        print("\(name) Hello")
        action("1", "2", "3")
        
    }
}

#Preview {
    FunctionTest()
}
