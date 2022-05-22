//
//  SearchTableViewController.swift
//  News
//
//  Created by Imani Abayakoon on 14/5/2022.
//

import UIKit

protocol SearchTableDelegate {
    func passSelectedValue(selected name: String)
}


class SearchTableViewController: UITableViewController, UISearchResultsUpdating{
    
    var delegate: SearchTableDelegate!
    
    var newsTitles = [SearchTableCellViewModel]()
    var filteredNewsTitles = [SearchTableCellViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return newsTitles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SearchTableViewCellValue else{
            fatalError()
        }
        
        cell.configure(with: newsTitles[indexPath.row])
        return cell
       
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let articleView = storyboard.instantiateViewController(identifier: "ArticleViewController") as! ArticleViewController
        self.navigationController?.pushViewController(articleView, animated: true)
        articleView.articleTitle = newsTitles[indexPath.row].title
        articleView.articleDetail = newsTitles[indexPath.row].content
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let inputText = searchController.searchBar.text, !inputText.isEmpty else {
           return
        }
        
        APICaller.shared.searchAllNews(with: inputText) { [weak self] result in
            switch result{
            case .success(let articles):
                self?.newsTitles = articles.compactMap({
                    SearchTableCellViewModel(
                        title: $0.title ?? "No Title",
                        content: $0.content ?? "No Content"
                    )
                })
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
                 
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }


}

class SearchTableViewCellValue: UITableViewCell{
    
    @IBOutlet weak var newsTitle: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with viewModel: SearchTableCellViewModel){
        newsTitle.text = viewModel.title
    }
}
