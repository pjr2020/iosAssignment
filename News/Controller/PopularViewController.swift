//
//  PopularViewController.swift
//  News
//
//  Created by Jianrui Pei on 2/5/2022.
//

import Foundation
import UIKit
import SideMenu


class PopularViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var sideMenu : SideMenuNavigationController?
    var newsArticles = [HomeViewModel]()
    var category: String = "Default"
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sideMenuOpen()
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        
        fetchPopularNews()
        
    }
    
    // Functiion to fetch popular news articles
    private func fetchPopularNews(){
        
        if (category == "Default"){
            APICaller.shared.getPopularNews{ [weak self] result in
                switch result{
                case .success(let articles):
                    self?.newsArticles = articles.compactMap({
                        HomeViewModel(
                                title: $0.title ?? "No Title",
                                imageURL: URL(string: $0.urlToImage ?? ""),
                                source: $0.source.name ?? "No Source",
                                publishedAt: $0.publishedAt ?? "No Date",
                                content: $0.content ?? "No content"
                        )
                    })

                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }else {
            APICaller.shared.fetchByCategory(with: category) { [weak self] result in
                switch result{
                case .success(let articles):
                    print("Articles \(articles)")
                    self?.newsArticles = articles.compactMap({
                        HomeViewModel(
                                title: $0.title ?? "No Title",
                                imageURL: URL(string: $0.urlToImage ?? ""),
                                source: $0.source.name ?? "No Source",
                                publishedAt: $0.publishedAt ?? "No Date",
                                content: $0.content ?? "No content"
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
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArticles.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{

        guard let cell =  tableView.dequeueReusableCell(withIdentifier: "PopularCell", for: indexPath) as? PopularTableViewCell else{
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

    
    // Function to handle side menu
    func sideMenuOpen(){
        sideMenu = SideMenuNavigationController(rootViewController: SideMenuTableViewController())
        sideMenu?.leftSide = true
        //Adding the draging option
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        sideMenu?.setNavigationBarHidden(true, animated: true)

    }
    

    @IBAction func sideMenuTapped(_ sender: Any) {
        present(sideMenu!, animated: true, completion: nil)
    }
    
}

class PopularTableViewCell:UITableViewCell{
    @IBOutlet weak var PopularImage: UIImageView!
    @IBOutlet weak var PopularTitle: UIButton!
    @IBOutlet weak var PopularTimeAndSource: UILabel!
    
    func configure(with viewModel: HomeViewModel){
        PopularTitle.setTitle(String(viewModel.title.prefix(30))+"...", for: .normal)
        PopularTimeAndSource.text = viewModel.source
        
        //Cache image if already loaded
        if let imageData = viewModel.imageData{
            PopularImage.image = UIImage(data: imageData)
        }else if let url = viewModel.imageURL{
            URLSession.shared.dataTask(with: url){[weak self] data, _, error in
                guard let data = data, error == nil else{
                    return
                }
                
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.PopularImage.image = UIImage(data: data)
                }
            }.resume()
        }
    }

}
