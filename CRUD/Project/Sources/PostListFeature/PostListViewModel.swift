import Foundation
import Combine
import Moya

class PostListViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var errorMessage: String?

    private let provider = MoyaProvider<API>()

    func fetchPosts() {
        errorMessage = nil

        provider.request(.getAllPosts) { [weak self] result in
            switch result {
            case .success(let response):
                do {
                    let posts = try JSONDecoder().decode([Post].self, from: response.data)
                    DispatchQueue.main.async {
                        self?.posts = posts
                    }
                } catch {
                    DispatchQueue.main.async {
                        self?.errorMessage = "디코딩 오류: \(error.localizedDescription)"
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.errorMessage = "API 요청 실패: \(error.localizedDescription)"
                }
            }
        }
    }
}
