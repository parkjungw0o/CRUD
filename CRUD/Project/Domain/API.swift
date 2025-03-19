//
//  API.swift
//  CRUD
//
//  Created by 박정우 on 3/19/25.
//

import Foundation
import Moya

// 제공하는 서비스 정의
public enum API {
    case fetchPost(data: PostRequest)  // 게시글 생성 (POST)
    case deletePost(boardID: Int)       // 게시글 삭제 (DELETE)
    case updatePost(data: PostRequest, boardID: Int) // 게시글 수정 (PATCH)
    case getPost(boardID: Int)          // 게시글 조회 (GET)
    case getAllPosts        // 모든 게시글 조회
}

// - BaseUrl: 기본 도메인 작성
extension API: TargetType {
    public var baseURL: URL {
        return URL(string: "https://port-0-boardios-lz1cq56f81af005d.sel4.cloudtype.app")!
    }

    // - Path: 기본 Path를 정의 (endpoint 작성)
    public var path: String {
        switch self {
        case .fetchPost:
            return "/posts"
        case .deletePost(let boardID),
             .updatePost(_, let boardID),
             .getPost(let boardID):
            return "/posts/\(boardID)" // 개별 게시글 조회, 수정, 삭제 경로
        case .getAllPosts:
            return "/posts" // 모든 게시글 조회 경로
        }
    }

    // - Method: 어떤 방식으로 통신할 것인지 정의
    public var method: Moya.Method {
        switch self {
        case .fetchPost:
            return .post
        case .deletePost:
            return .delete
        case .updatePost:
            return .patch
        case .getPost, .getAllPosts:
            return .get
        }
    }

    // - task: 어떻게 데이터를 전송할 것인지 정의
    public var task: Task {
        switch self {
        case .fetchPost(let data),
             .updatePost(let data, _):
            return .requestJSONEncodable(data)    //JSON 데이터를 바디에 포함하여 보냄
        case .deletePost, .getPost, .getAllPosts:
            return .requestPlain           // requstPlain 데이터 없이 요청만 보냄
        }
    }

    // - headers: HTTP 요청 헤더 정의
    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
