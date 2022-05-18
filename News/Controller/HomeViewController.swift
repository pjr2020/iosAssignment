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
    
    var items1: Response?

    @IBOutlet weak var sideMenuButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        
        sideMenuOpen()
        var items: Response?
        let host = "https://newsapi.org/v2/everything?"
        let topic = "\"Apple reportedly hires a longtime Ford executive for its car project\"".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        print("Topic is: \(topic)")
        let category = "business"
        let API_KEY = "a2a6e11225744c1d86e70b798e97dd1c"
        let url = host + "q=" + topic! + "&apiKey=" + API_KEY
        print("URL is: \(url)")
        print("The data is:")
        var ans: Response?
        if let a = URL(string: url) {
            if let data = try? Data(contentsOf: a) {
                ans = parse(json: data)!
               
                print(ans?.status ?? "pending")
            }
        }
        let tableurl = "https://newsapi.org/v2/everything?apiKey=" + API_KEY + "&pageSize=3"

        
        let p = host + "q=" + topic! + "&apiKey=" + API_KEY
        if let b = URL(string: tableurl) {
            if let newdata = try? Data(contentsOf: b) {
                items1 = parse(json: newdata)!
            }
        }
        
        print("The status of array is: \(items1?.status)")
        print(items1?.articles[0].title)
    }

    func parse(json: Data) -> Response? {
        let decoder = JSONDecoder()
        var result: Response?
        do {
            result = try? decoder.decode(Response.self, from: json)
        } catch {
            print(error.localizedDescription)
        }
        return result
    }
    
//    func getData (from url: String) {
        
        
//        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error
//            in
//            guard let data = data, error == nil else {
//                print("Error!!!")
//                return
 //           }
//
 //           var result: Response?
 //           do {
 //               result = try JSONDecoder().decode(Response.self, from: data)
 //           } catch {
 //               print("Failed to convert JSON.. \(error.localizedDescription)")
 //               print("xyz")
                
 //           }
            
 //           guard let json = result else {
 //               return
 //           }
            
 //           print(json.status)
 //           print(json.articles[0].title)
 //           print(json.articles[0].author)
 //           print(json.articles[0].description)

 //       })
 //       task.resume()
        

 //   }
    
    
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
        cell.ArticleTitle?.setTitle("Title: \(items1?.articles[0].title ?? "dummy")", for: .normal)
    //cell.ArticleImage?.image = UIImage(systemName: "Homekit")

        cell.ArticleImage.image = UIImage(named: "test")
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


struct Response: Codable {
    let status: String
    let totalResults: Int
    let articles: [Articles]
}

struct Articles: Codable {
    let source: Sources
    let author: String
    let title: String
    let description: String
    let url: String
    let urlToImage: String
    let publishedAt: String
    let content: String
}

struct Sources: Codable {
    let id: String
    let name: String
}
