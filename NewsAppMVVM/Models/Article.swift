//
//  Article.swift
//  NewsAppMVVM
//
//  Created by Nozomu Kuwae on 9/29/19.
//  Copyright © 2019 Nozomu Kuwae. All rights reserved.
//

import Foundation

struct ArticleResponse: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let title: String
    let description: String?
}
