//
//  HomeViewController.swift
//  News
//
//  Created by Jianrui Pei on 2/5/2022.
//

import Foundation
import UIKit


class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    var articles = [1,2,3]

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
        cell.ArticleImage.image = UIImage(named: "test")
        cell.ArticleTitle?.setTitle("Title\(index)", for: .normal)
        cell.ArticleTimeAndSource?.text = "Time and Source\(index)"
    return cell

    }
}

class ArticleTableViewCell:UITableViewCell{
    
    @IBOutlet weak var ArticleTitle: UIButton!
    @IBOutlet weak var ArticleImage: UIImageView!
    @IBOutlet weak var ArticleTimeAndSource: UILabel!
    
}


