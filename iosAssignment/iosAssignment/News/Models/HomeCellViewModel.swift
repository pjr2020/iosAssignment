//
//  HomeCellViewModel.swift
//  News
//
//  Created by Tejas Kesharwani on 17/5/2022.
//

import Foundation
import UIKit

class HomeCellViewModel{
    let title: String
    let source: String
    let time: String
    
    init(title: String, time: String, source: String) {
        self.title = title
        self.time = time
        self.source = source
    }
}
