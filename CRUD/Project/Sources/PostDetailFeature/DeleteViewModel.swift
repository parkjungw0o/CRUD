//
//  DeleteViewModel.swift
//  CRUD
//
//  Created by 박정우 on 3/19/25.
//
import Foundation
import Moya

class DeleteViewModel: ObservableObject {
    @Published var errorMessage: String?
    @Published var successMessage: String?

    private let provider = MoyaProvider<API>()

    func deletePost(boardID: Int, completion: @escaping (Bool) -> Void) {
        provider.request(.deletePost(boardID: boardID)) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.successMessage = "게시글이 삭제되었습니다."
                    completion(true)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = "삭제 실패: \(error.localizedDescription)"
                    completion(false)
                }
            }
        }
    }
}
