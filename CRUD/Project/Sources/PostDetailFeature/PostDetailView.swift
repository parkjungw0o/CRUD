import SwiftUI

struct PostDetailView: View {
    let postID: Int
    @StateObject private var viewModel = PostDetailViewModel()
    @StateObject private var updateViewModel = PostUpdateViewModel()
    @StateObject private var deleteViewModel = DeleteViewModel()

    @State private var isEditing = false
    @State private var editedTitle = ""
    @State private var editedContent = ""
    @Environment(\.dismiss) private var dismiss // 이전 화면으로 돌아가기

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if viewModel.isLoading {
                ProgressView("로딩 중...")
            } else if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
            } else if let post = viewModel.post {
                HStack {
                    if isEditing {
                        TextField("제목을 입력하세요", text: $editedTitle)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    } else {
                        Text(post.title)
                            .font(.largeTitle)
                            .bold()
                    }
                    
                    Spacer()
                    
                    Button {
                        // 삭제 요청
                        deleteViewModel.deletePost(boardID: post.id) { success in
                            if success {
                                dismiss() // 삭제 성공 시 PostListView로 돌아가기
                            }
                        }
                    } label: {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }

                    Button {
                        if isEditing {
                            // 수정 요청
                            updateViewModel.updatePost(
                                boardID: post.id,
                                title: editedTitle,
                                content: editedContent
                            ) { success in
                                if success {
                                    viewModel.fetchPost(by: post.id) // 수정 후 새로고침
                                    isEditing = false // 편집 모드 종료
                                }
                            }
                        } else {
                            // 편집 모드 활성화
                            editedTitle = post.title
                            editedContent = post.content
                            isEditing = true
                        }
                    } label: {
                        Image(systemName: isEditing ? "checkmark" : "pencil")
                    }
                }
                
                Divider()

                if isEditing {
                    TextEditor(text: $editedContent)
                        .frame(minHeight: 150)
                        .border(Color.gray, width: 1)
                        .padding(.top, 5)
                } else {
                    Text(post.content)
                        .font(.body)
                        .padding(.top, 5)
                }

                Spacer()
            }
        }
        .padding()
        .navigationTitle("게시물 상세")
        .onAppear {
            viewModel.fetchPost(by: postID)
        }
        .alert(isPresented: Binding<Bool>(
            get: { updateViewModel.successMessage != nil },
            set: { _ in updateViewModel.successMessage = nil }
        )) {
            Alert(title: Text("알림"), message: Text(updateViewModel.successMessage ?? ""), dismissButton: .default(Text("확인")))
        }
        .alert(isPresented: Binding<Bool>(
            get: { deleteViewModel.successMessage != nil },
            set: { _ in deleteViewModel.successMessage = nil }
        )) {
            Alert(title: Text("알림"), message: Text(deleteViewModel.successMessage ?? ""), dismissButton: .default(Text("확인")))
        }
    }
}

