//
//  HomeViewController.swift
//  News
//
//  Created by Jianrui Pei on 2/5/2022.
//

import Foundation
import UIKit
import SideMenu

class HomeViewController: UIViewController {
    
    var sideMenu: SideMenuNavigationController?

    @IBOutlet weak var sideMenuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func sideMenuTapped(_ sender: Any) {
        
    }
    

}
