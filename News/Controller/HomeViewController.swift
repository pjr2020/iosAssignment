//
//  HomeViewController.swift
//  News
//
//  Created by Jianrui Pei on 2/5/2022.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let host = "https://newsapi.org/v2/everything?"
        let topic = "\"Apple reportedly hires a longtime Ford executive for its car project\"".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        print("Topic is: \(topic)")
        let API_KEY = "a2a6e11225744c1d86e70b798e97dd1c"
        let url = host + "q=" + topic! + "&apiKey=" + API_KEY
        print("URL is: \(url)")
        print("The data is:")
        getData(from: url)
        
        
        
    }
    
    func getData (from url: String) {
        
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error
            in
            guard let data = data, error == nil else {
                print("Error!!!")
                return
            }
            
            var result: Response?
            do {
                result = try JSONDecoder().decode(Response.self, from: data)
            } catch {
                print("Failed to convert JSON.. \(error.localizedDescription)")
            }
            
            guard let json = result else {
                return
            }
            
            print(json.status)
            print(json.articles[0].title)
            print(json.articles[0].author)
            print(json.articles[0].description)
            
        })
        task.resume()
    }

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
