//
//  PostViewModel.swift
//  CRUD
//
//  Created by 박정우 on 3/19/25.
//

import Foundation
import Moya

final class PostViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var content: String = ""
    @Published var successMessage: String? = nil
    
    private let PostProvuder = MoyaProvider<API>()

    func SubmitPost(title: String, content: String) {
        let request = PostRequest(title: title, content: content)
        PostProvuder.request(.fetchPost(data: request)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                switch statusCode {
                case 200..<300:
                    self.successMessage = "게시글 작성 성공"
                    print("Success: \(statusCode)")
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                     self.successMessage = nil
                    }
                    
                default:
                    print(result)
                    print("Unexpected status code: \(statusCode)")
                    print(String(data: response.data, encoding: .utf8) ?? "")
                }
            case .failure(let error):
                print("Network request failed: \(error.localizedDescription)")
            }
        }
    }
}
