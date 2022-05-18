//
//  SearchListViewController.swift
//  News
//
//  Created by Imani Abayakoon on 18/5/2022.
//

import Foundation
import UIKit
import SideMenu

class SearchListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
//    var sideMenu: SideMenuNavigationController?
//
//
//    @IBOutlet weak var sideMenuButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    var newsArticles = [HomeViewModel]()
    var tagValue: String = "Bitcoin"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        
        title = tagValue
        
        fetchAllNews()
        
    }
    
    private func fetchAllNews(){
        
        APICaller.shared.searchAllNews(with: tagValue) { [weak self] result in
            switch result{
            case .success(let articles):
                print("Articles \(articles)")
                self?.newsArticles = articles.compactMap({
                    HomeViewModel(
                            title: $0.title ?? "No Title",
                            imageURL: URL(string: $0.urlToImage ?? ""),
                            source: $0.source.name ?? "No Source",
                            publishedAt: $0.publishedAt ?? "No Date",
                            content: $0.content ?? "No Content"
                    )
                })
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return newsArticles.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as? SearchListTableViewCell else{
            fatalError()
        }
        
        cell.configure(with: newsArticles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let articleView = storyboard.instantiateViewController(identifier: "ArticleViewController") as! ArticleViewController
        self.navigationController?.pushViewController(articleView, animated: true)
        articleView.articleTitle = newsArticles[indexPath.row].title
        articleView.articleDetail = newsArticles[indexPath.row].content
    }
    
//    func sideMenuOpen(){
//        sideMenu = SideMenuNavigationController(rootViewController: SideMenuTableViewController())
//        sideMenu?.leftSide = true
//        //Adding the draging option
//        SideMenuManager.default.addPanGestureToPresent(toView: view)
//        SideMenuManager.default.leftMenuNavigationController = sideMenu
//        sideMenu?.setNavigationBarHidden(true, animated: true)
//
//    }
//
//
//    @IBAction func sideMenuTapped(_ sender: Any) {
//        present(sideMenu!, animated: true, completion: nil)
//    }
    
}

class SearchListTableViewCell:UITableViewCell{
    @IBOutlet weak var articleImageView: UIImageView!
    
    @IBOutlet weak var articleTitle: UILabel!
    
    @IBOutlet weak var articleSouce: UILabel!
    
    func configure(with viewModel: HomeViewModel){
        articleTitle.text = viewModel.title
        articleSouce.text = viewModel.source
        
        //Cache image if already loaded
        if let imageData = viewModel.imageData{
            articleImageView.image = UIImage(data: imageData)
        }else if let url = viewModel.imageURL{
            URLSession.shared.dataTask(with: url){[weak self] data, _, error in
                guard let data = data, error == nil else{
                    return
                }
                
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.articleImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
    
}
