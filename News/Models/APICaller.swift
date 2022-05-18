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
    let New_API_KEY = "1f602eef3e5240008aa943889e02a7f6"
    
    struct Constants {
        static let topHeadlinesApiUrl = URL(string: "https://newsapi.org/v2/top-headlines?country=AU&apiKey=1f602eef3e5240008aa943889e02a7f6")
        
        static let searchApiUrl =  "https://newsapi.org/v2/everything?sortedBy=popularity&apiKey=1f602eef3e5240008aa943889e02a7f6&q="
        
        static let categoryApiUrl = "https://newsapi.org/v2/top-headlines?apiKey=1f602eef3e5240008aa943889e02a7f6&category="
    }
    
    private init() {}
    
    public func searchAllNews(with query: String, completion: @escaping (Result<[Article], Error>) ->Void){
        
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
    
    public func getTopHeadlines(completion: @escaping (Result<[Article], Error>) ->Void){
        
        let urlString = Constants.topHeadlinesApiUrl
        
        guard let url = urlString else{
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
    
    public func fetchByCategory(with query: String, completion: @escaping (Result<[Article], Error>) ->Void){
        
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else{
            return
        }
        
        let urlString = Constants.categoryApiUrl + query
        
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


