//
//  PostWebDTO.swift
//  PostIt
//
//  Created by Marc Garcia Teodoro on 17/5/25.
//

import Foundation

struct PostWebDTO: Encodable {
    let title: String
    let posts: [PostDTO]
}
