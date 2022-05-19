//
//  SearchViewController.swift
//  News
//
//  Created by Jianrui Pei on 2/5/2022.
//

import Foundation
import UIKit
import SideMenu
import TTGTagCollectionView

class SearchViewController: UIViewController, UISearchControllerDelegate, SearchTableDelegate, TTGTextTagCollectionViewDelegate {
    
    func passSelectedValue(selected name: String) {
        print("Name \(name)")
    }
    
    var sideMenu: SideMenuNavigationController?

    var resultController: UISearchController!
    private var resultTableController: SearchTableViewController!
    
    let collectionView = TTGTextTagCollectionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sideMenuOpen()
        
        configureSearchController()
        
        collectionView.layoutMargins = UIEdgeInsets(top: 30, left: 100, bottom: 0, right: 0)
        collectionView.alignment = .center
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        addSearchTags()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: 400)
    }
    
    func addSearchTags(){
        let config = TTGTextTagConfig()
        config.backgroundColor = .lightGray
        config.textColor = .black
        config.borderColor = .gray
        config.borderWidth = 1
        
        collectionView.addTags(["Africa", "Asia", "Australia", "Europe", "Middle East", "Latin America", "UK", "US", "Canada", "Football", "Cricket", "Rugby", "Golf", "Tennis", "Bitcoin", "Apple", "SriLanka", "India", "Depp", "Heard", "Elections", "Philippines", "Twitter", "Elon", "Trump", "Ukraine", "NBA", "Covid", "Climate", "Oil", "Dubai", "Travel", "Culture", "MI5"], with: config)
        
    }
    
    func textTagCollectionView(_ textTagCollectionView: TTGTextTagCollectionView!, didTapTag tagText: String!, at index: UInt, selected: Bool, tagConfig config: TTGTextTagConfig!) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let searchListView = storyboard.instantiateViewController(identifier: "SearchListViewController") as! SearchListViewController
        self.navigationController?.pushViewController(searchListView, animated: true)

        searchListView.tagValue = tagText
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
