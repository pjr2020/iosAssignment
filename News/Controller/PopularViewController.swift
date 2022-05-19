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
    
    private func fetchPopularNews(){
        
        if (category == "Default"){
            APICaller.shared.getPopularNews{ [weak self] result in
                switch result{
                case .success(let articles):
                   // print(articles)
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
            
//            guard let categoryText = !category.isEmpty else {
//               return
//            }
            print("category\(category)")
            
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

    var articles = [1,2,3]

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
        PopularTitle.setTitle(viewModel.title, for: .normal)
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
