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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        
        sideMenuOpen()
        
    }

    var articles = [1,2,3]
    var newslist = [HomeCellViewModel]()
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return articles.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
    let cell =  tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleTableViewCell
    let index = articles[indexPath.row]
    //cell.ArticleImage?.image = UIImage(systemName: "Homekit")
        let query="apple&pageSize=3"
      

        APICaller.shared.getAllNews(with: query) { [weak self] result in
            switch result {
            case .success(let articles):
                print("Articles \(articles)")
                self?.newslist = articles.compactMap({
                    HomeCellViewModel(title: $0.title ?? "No title", time: $0.publishedAt ?? "No time", source: $0.source.name ?? "No source")
                })
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Not working")
                print(error)
            }
        }
        
        tableView.reloadData()
        print(self.newslist.count)
        cell.ArticleImage.image = UIImage(named: "test")
        cell.ArticleTitle?.setTitle(self.newslist[indexPath.row].title, for: .normal)
        cell.ArticleTimeAndSource?.text = "Time and Source\(index)"
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
    
}



