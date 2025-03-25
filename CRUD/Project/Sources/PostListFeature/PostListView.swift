import SwiftUI

struct PostListView: View {
    @StateObject var viewModel = PostListViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    List {
                        if viewModel.posts.isEmpty{
                            Text("게시물이 없습니다!")
                        }
                        else {
                            ForEach(viewModel.posts) { post in
                                NavigationLink(destination: PostDetailView(postID: post.id)
                                    .onDisappear {
                                        viewModel.fetchPosts()
                                    }
                                ) {
                                    Text(post.title)
                                        .font(.headline)
                                }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
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

