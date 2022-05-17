//
//  HomeViewController.swift
//  News
//
//  Created by Jianrui Pei on 2/5/2022.
//

import Foundation
import UIKit
import SideMenu

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var sideMenu: SideMenuNavigationController?
    @IBOutlet weak var sideMenuButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    var newsArticles = [HomeViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        
        sideMenuOpen()
        fetchAllNews()
        
    }
    
    private func fetchAllNews(){
        APICaller.shared.getTopHeadlines{ [weak self] result in
            switch result{
            case .success(let articles):
               // print(articles)
                self?.newsArticles = articles.compactMap({
                    HomeViewModel(
                            title: $0.title ?? "No Title",
                            imageURL: URL(string: $0.urlToImage ?? ""),
                            source: $0.source.name ?? "No Source",
                            publishedAt: $0.publishedAt ?? "No Date"
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
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? ArticleTableViewCell else{
            fatalError()
        }
        
        cell.configure(with: newsArticles[indexPath.row])
        return cell
    }
    
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

class ArticleTableViewCell:UITableViewCell{
    
    @IBOutlet weak var ArticleTitle: UIButton!
    @IBOutlet weak var ArticleImage: UIImageView!
    @IBOutlet weak var ArticleTimeAndSource: UILabel!
    
    func configure(with viewModel: HomeViewModel){
        ArticleTitle.setTitle(viewModel.title, for: .normal)
        ArticleTimeAndSource.text = viewModel.source
        
        //Cache image if already loaded
        if let imageData = viewModel.imageData{
            ArticleImage.image = UIImage(data: imageData)
        }else if let url = viewModel.imageURL{
            URLSession.shared.dataTask(with: url){[weak self] data, _, error in
                guard let data = data, error == nil else{
                    return
                }
                
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.ArticleImage.image = UIImage(data: data)
                }
            }.resume()
        }
    }
    
}


