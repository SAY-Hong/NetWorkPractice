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

