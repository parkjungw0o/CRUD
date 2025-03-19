//
//  BoardList.swift
//  CRUD
//
//  Created by 박정우 on 3/19/25.
//
import SwiftUI

struct PostListView: View {
    @StateObject var viewModel = PostListViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    // 로딩 중일 때 ProgressView 표시
                    ProgressView("로딩중...")
                } else if let error = viewModel.errorMessage {
                    // 에러 발생 시 에러 메시지 표시
                    Text(error)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    // 게시물이 있을 때 List로 표시
                    List(viewModel.posts) { post in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(post.title)
                                .font(.headline)
                            Text(post.content)
                                .font(.body)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("전체 게시물")
        }
        .onAppear {
            viewModel.fetchPosts()
        }
    }
}

#Preview {
    PostListView()
}
