//
//  ContentView.swift
//  CRUD
//
//  Created by 박정우 on 3/19/25.

import SwiftUI

struct PostView: View {
    @State var title: String = ""
    @State var content: String = ""
    @ObservedObject var viewModel = PostViewModel()
    var body: some View {
        NavigationView {
            VStack {
                TextField("제목을 입력해주세요", text: $title)
                    .padding(.leading, 35)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .frame(width: 350,height: 50)
                            .foregroundStyle(.yellow)
                    )
                
                TextField("내용을 입력해주세요", text: $content)
                    .padding(.leading, 35)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .frame(width: 350,height: 50)
                            .foregroundStyle(.yellow)
                    )
                    .padding(.top, 30)
                
                Button {
                    viewModel.SubmitPost(title: title, content: content)
                }label: {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .padding(.vertical, 13)
                        .padding(.horizontal, 170)
                        .background(.blue)
                        .cornerRadius(10)
                    
                        
                }
                .padding(.top,30)
                
                if let message = viewModel.successMessage {
                               Text(message)
                                   .foregroundColor(.green)
                                   .padding()
                                   .transition(.opacity)
                }
                
                Spacer()
            }
            .navigationTitle("게시글 작성")
            .padding(.top, 20)
        }
    }
}

#Preview {
    PostView()
}
