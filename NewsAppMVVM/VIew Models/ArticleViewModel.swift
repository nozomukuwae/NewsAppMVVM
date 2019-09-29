//
//  ArticleViewModel.swift
//  NewsAppMVVM
//
//  Created by Nozomu Kuwae on 9/29/19.
//  Copyright © 2019 Nozomu Kuwae. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct ArticleListViewModel {
    let articlesVM: [ArticleViewModel]
}

extension ArticleListViewModel {
    init(_ articles: [Article]) {
        // You can also use compactMap instead of map here
        self.articlesVM = articles.map(ArticleViewModel.init)
    }
}

extension ArticleListViewModel {
    func articleAt(_ index: Int) -> ArticleViewModel {
        return articlesVM[index]
    }
    
    func numberOfArticles() -> Int {
        return articlesVM.count
    }
}


struct ArticleViewModel {
    let article: Article
    
    init(_ article: Article) {
        self.article = article
    }
}

extension ArticleViewModel {
    var title: Observable<String> {
        return Observable<String>.just(article.title)
    }
    
    var description: Observable<String> {
        return Observable<String>.just(article.description ?? "")
    }
}
