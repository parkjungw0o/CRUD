//
//  Post.swift
//  CRUD
//
//  Created by 박정우 on 3/19/25.
//

import Foundation

struct Post: Identifiable, Codable {
    var id: Int
    var title: String
    var content: String
}
