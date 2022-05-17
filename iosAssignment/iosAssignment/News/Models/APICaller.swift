//
//  APICaller.swift
//  News
//
//  Created by Imani Abayakoon on 13/5/2022.
//

import Foundation

final class APICaller{
    static let shared = APICaller()
    let API_KEY = "a2a6e11225744c1d86e70b798e97dd1c"
    
    struct Constants {
        static let newsApiUrl = URL(string: "https://newsapi.org/v2/everything?sortedBy=popularity&apiKey=a2a6e11225744c1d86e70b798e97dd1c&q=")
        
        static let searchApiUrl =  "https://newsapi.org/v2/everything?sortedBy=popularity&apiKey=a2a6e11225744c1d86e70b798e97dd1c&q="
    }
    
    private init() {}
    
    public func getAllNews(with query: String, completion: @escaping (Result<[Article], Error>) ->Void){
        
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else{
            return
        }
        
        let urlString = Constants.searchApiUrl + query
        
        guard let url = URL(string: urlString) else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    print("Result \(result.articles.count)")
                    completion(.success(result.articles))
                }
                catch{
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
}

// Models
struct APIResponse: Codable{
    let status: String?
    let totalResults: Int?
    let articles: [Article]
}

struct Article: Codable{
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

struct Source: Codable{
    let id: String?
    let name: String?
}


