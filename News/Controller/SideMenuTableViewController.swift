//
//  SideMenuTableViewController.swift
//  News
//
//  Created by Imani Abayakoon on 10/5/2022.
//

import UIKit

protocol SideMenuTableDelegate {
    func passSelectedValue(selected title: String)
}

class SideMenuTableViewController: UITableViewController {
    
    let tableRowData = ["Top Stories", "Business", "Health", "Sports", "Technology", "Entertainment and Arts", "Science"]
    
    var delegate: SideMenuTableDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tableRowData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tableRowData[indexPath.row]
        cell.backgroundColor = UIColor(red: 40/255.0, green: 200/255.0, blue: 80/255.0, alpha: 0.5)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        switch indexPath.row{
        case 0:
            let homeView = storyboard.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(homeView, animated: true)
            homeView.category = "Default"
            break
        case 1:
            let homeView = storyboard.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(homeView, animated: true)
            homeView.category = "business"
            break
        case 2:
            let homeView = storyboard.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(homeView, animated: true)
            homeView.category = "health"
            break
        case 3:
            let homeView = storyboard.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(homeView, animated: true)
            homeView.category = "sports"
            break
        case 4:
            let homeView = storyboard.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(homeView, animated: true)
            homeView.category = "technology"
            break
        case 5:
            let homeView = storyboard.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(homeView, animated: true)
            homeView.category = "entertainment"
            break
        case 6:
            let homeView = storyboard.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(homeView, animated: true)
            homeView.category = "science"
            break
        default:
            break
        }
    }

}
