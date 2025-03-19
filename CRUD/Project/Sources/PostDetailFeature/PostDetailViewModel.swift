//
//  PostDetailViewModel.swift
//  CRUD
//
//  Created by 박정우 on 3/19/25.
//

import Foundation
import Foundation
import Combine
import Moya

class PostDetailViewModel: ObservableObject {
    @Published var post: Post?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let provider = MoyaProvider<API>()

    func fetchPost(by id: Int) {
        isLoading = true
        errorMessage = nil

        provider.request(.getPost(boardID: id)) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
            }

            switch result {
            case .success(let response):
                do {
                    let post = try JSONDecoder().decode(Post.self, from: response.data)
                    DispatchQueue.main.async {
                        self?.post = post
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
