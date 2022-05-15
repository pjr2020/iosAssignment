//
//  SearchViewController.swift
//  News
//
//  Created by Jianrui Pei on 2/5/2022.
//

import Foundation
import UIKit
import SideMenu

class SearchViewController: UIViewController, UISearchControllerDelegate, SearchTableDelegate {
    func passSelectedValue(selected name: String) {
        print("Name \(name)")
    }
    
    
    var sideMenu: SideMenuNavigationController?
    

    //@IBOutlet weak var tableView: UITableView!
    var resultController: UISearchController!
    private var resultTableController: SearchTableViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sideMenuOpen()
        
        configureSearchController()
    }
    
    func configureSearchController() {
        resultTableController = (storyboard?.instantiateViewController(withIdentifier: "resultTable") as! SearchTableViewController)
        resultTableController.delegate = self
        resultController = UISearchController(searchResultsController: resultTableController)
        resultController?.searchResultsUpdater = resultTableController
        navigationItem.searchController = resultController
        resultController?.obscuresBackgroundDuringPresentation = true
        definesPresentationContext = true
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
