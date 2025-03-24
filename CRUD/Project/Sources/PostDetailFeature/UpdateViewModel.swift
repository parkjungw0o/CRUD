import Foundation
import Moya

class PostUpdateViewModel: ObservableObject {
    @Published var successMessage: String?
    @Published var errorMessage: String?
    
    private let provider = MoyaProvider<API>()

    func updatePost(boardID: Int, title: String, content: String, completion: @escaping (Bool) -> Void) {
        let request = PostRequest(title: title, content: content)
        
        provider.request(.updatePost(data: request, boardID: boardID)) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    if (200..<300).contains(response.statusCode) {
                        self?.successMessage = "게시글 수정 완료"
                        print(response.statusCode)
                        print("수정 성공")
                        completion(true)
                    } else {
                        self?.errorMessage = "예상치 못한 응답 코드: \(response.statusCode)"
                        completion(false)
                    }
                case .failure(let error):
                    self?.errorMessage = "게시글 수정 실패: \(error.localizedDescription)"
                    completion(false)
                }
            }
        }
    }
}

