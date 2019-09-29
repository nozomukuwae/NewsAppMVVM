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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        populateNews()
    }
    
    private func populateNews() {
        let filePath = Bundle.main.path(forResource: "Private", ofType: "plist")
        let plist = NSDictionary(contentsOfFile: filePath!)
        guard let apiKey = plist?["apiKey"] as? String else { fatalError() }
        let resource = Resource<ArticleResponse>(url: URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=" + apiKey)!)
        
        URLRequest.load(resource: resource)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
    }
}
