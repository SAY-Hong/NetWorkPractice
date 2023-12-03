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
struct ContentView: View {
//    @StateObject var contentModel = ContentViewModel() 
    @ObservedObject private var contentModel = ContentViewModel()
    //MARK: @StateObject와 @ObservedObject
/*
     - 공통: 관찰 중인 객체의 변경에 반응 -> 화면 업뎃
     - @StateObject: 관찰되는 객체 -> 화면 구조가 재생성되어도 파괴X.
     - 스유가 화면을 만들거나 다시 그릴 수 있는 가능성이 있는 경우 -> ObservedObject 안전X.
     - 둘의 큰 차이점 -> 라이플 사이클의 관리 여부.
*/
    
    
    var body: some View {
        VStack {
            List {
                ForEach(contentModel.posts, id: \.self) { item in
                    Text(item)
                }
                
                ForEach(contentModel.users, id: \.self) { item in
                    Text(item)
                }
            }
            //MARK: Request Button 1
            Button {
                contentModel.requestPost()
            } label: {
                Text("Request Post")
            }
            
            //MARK: Request Button 2
            Button {
                contentModel.requestUser()
            } label: {
                Text("Request User")
            }
        }
    }
}

#Preview {
    ContentView()
}

