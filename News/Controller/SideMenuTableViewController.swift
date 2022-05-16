//
//  SideMenuTableViewController.swift
//  News
//
//  Created by Imani Abayakoon on 10/5/2022.
//

import UIKit

class SideMenuTableViewController: UITableViewController {
    
    let tableRowData = ["Top Stories", "Business", "Health", "Sports", "Technology", "Entertainment and Arts", "Education"]

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
        switch indexPath.row{
        case 0:
            print("Navigate to top stories section")
            break
        case 1:
            print("Navigate to Business section")
            break
        case 2:
            print("Navigate to Health section")
            break
        case 3:
            print("Navigate to Sports section")
            break
        case 4:
            print("Navigate to Technology section")
            break
        case 5:
            print("Navigate to Entertainment and Arts secrtion")
            break
        case 6:
            print("Navigate to Education section")
        default:
            break
        }
    }

}
