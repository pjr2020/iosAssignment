//
//  HomeViewModel.swift
//  News
//
//  Created by Imani Abayakoon on 18/5/2022.
//

import Foundation
import UIKit

class HomeViewModel{
    let title: String
    let imageURL: URL?
    var imageData: Data? = nil
    let source: String
    let publishedAt: String
    let content: String
    
    init(
        title: String,
        imageURL: URL?,
        source: String,
        publishedAt: String,
        content: String
    ){
        self.title = title
        self.imageURL = imageURL
        self.source = source
        self.publishedAt = publishedAt
        self.content = content
    }
}
