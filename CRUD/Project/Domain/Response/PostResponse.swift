//
//  Response.swift
//  CRUD
//
//  Created by 박정우 on 3/19/25.
//

import Foundation

public struct PostResponse: Decodable {
    public let id: Int
    public let title: String
    public let content: String
}


