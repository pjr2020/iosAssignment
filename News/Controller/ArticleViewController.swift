//
//  ArticleViewController.swift
//  News
//
//  Created by Jianrui Pei on 2/5/2022.
//

import Foundation
import UIKit

class ArticleViewController: UIViewController {
    @IBOutlet weak var ArticleTitle: UILabel!
    
    @IBOutlet weak var ArticleDetail: UITextView!
    
    var articleTitle = String()
    var articleDetail = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ArticleTitle.text = articleTitle
        ArticleDetail.text = articleDetail
    }


}
