//
//  PostListViewModel.swift
//  CRUD
//
//  Created by 박정우 on 3/19/25.
//

import Foundation
import Combine
import Moya

class PostListViewModel: ObservableObject {
    @Published var posts: [PostResponse] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    private let provider = MoyaProvider<API>()
    
    // 전체 게시물을 가져오는 함수
    func fetchPosts() {
        isLoading = true
        errorMessage = nil
        
        provider.request(.getAllPosts) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
            }
            
            switch result {
            case .success(let response):
                do {
                    // JSON 응답을 [PostResponse] 배열로 디코딩
                    let posts = try JSONDecoder().decode([PostResponse].self, from: response.data)
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
