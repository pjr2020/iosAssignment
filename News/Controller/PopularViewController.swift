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

    
    @IBOutlet weak var tableView: UITableView!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sideMenuOpen()
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        
    }
    var articles = [1,2,3]

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return articles.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell1 =  tableView.dequeueReusableCell(withIdentifier: "PopularCell", for: indexPath)
        let cell = cell1 as! PopularTableViewCell
        let index = articles[indexPath.row]
    //cell.ArticleImage?.image = UIImage(systemName: "Homekit")
//

        cell.PopularImage.image = UIImage(named: "test")
        cell.PopularTitle?.setTitle("Title: \(index)", for: .normal)
        cell.PopularTimeAndSource?.text = "Time and Source\(index)"
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
    
}
