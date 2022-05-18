//
//  SearchTableCellViewModel.swift
//  News
//
//  Created by Imani Abayakoon on 14/5/2022.
//

import Foundation
import UIKit

class SearchTableCellViewModel{
    let title: String
    let content: String
    
    init(
        title: String,
        content: String
    ){
        self.title = title
        self.content = content
    }
}
