//
//  NewsTableViewController.swift
//  NewsAppMVVM
//
//  Created by Nozomu Kuwae on 9/29/19.
//  Copyright © 2019 Nozomu Kuwae. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NewsTableViewController: UITableViewController {
    private let disposeBag = DisposeBag()
    private var articleListVM: ArticleListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        populateNews()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleListVM?.numberOfArticles() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "articleTableViewCell", for: indexPath) as? ArticleTableViewCell else { fatalError() }
        
        guard let articleListVM = articleListVM else {
            return cell
        }
        
        let articleVM = articleListVM.articleAt(indexPath.row)
        articleVM.title
        .bind(to: cell.titleLabel.rx.text)
        .disposed(by: disposeBag)
        
        articleVM.description
        .bind(to: cell.descriptionLabel.rx.text)
        .disposed(by: disposeBag)
        
        return cell
    }
    
    private func populateNews() {
        let filePath = Bundle.main.path(forResource: "Private", ofType: "plist")
        let plist = NSDictionary(contentsOfFile: filePath!)
        guard let apiKey = plist?["apiKey"] as? String else { fatalError() }
        let resource = Resource<ArticleResponse>(url: URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=" + apiKey)!)
        
        URLRequest.load(resource: resource)
            .subscribe(onNext: { (articleResponse) in
                self.articleListVM = ArticleListViewModel(articleResponse.articles)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
            .disposed(by: disposeBag)
    }
}
