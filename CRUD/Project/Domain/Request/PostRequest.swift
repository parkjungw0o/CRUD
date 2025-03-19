//
//  Request.swift
//  CRUD
//
//  Created by 박정우 on 3/19/25.
//

import Foundation

public struct PostRequest: Codable {
    var title: String
    var content: String
  
    public init(title: String, content: String) {
        self.title = title
        self.content = content
    }
}
