import SwiftUI

struct PostListView: View {
    @StateObject var viewModel = PostListViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("로딩중...")
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                } else if viewModel.posts.isEmpty {
                    Text("게시물이 없습니다!")
                } else {
                    List(viewModel.posts) { post in
                        NavigationLink(destination: PostDetailView(postID: post.id)
                            .onDisappear {
                                viewModel.fetchPosts() // 디테일뷰에서 돌아오면 목록 새로고침
                            }
                        ) {
                            Text(post.title)
                                .font(.headline)
                        }
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

