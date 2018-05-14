//
//  ToDoCategory.swift
//  OdotList
//
//  Created by Weijie Lin on 5/8/18.
//  Copyright © 2018 Weijie Lin. All rights reserved.
//

import UIKit

struct ToDoCategory {
    
    var categoryName: String
    var categoryIcon: UIImage
    var categoryGradientColors: [CGColor]
    var categoryItems: [ToDoItem]
    
}

extension ToDoCategory: Hashable {
    
    var hashValue: Int {
        return categoryName.hashValue
    }
    
}

extension ToDoCategory: Equatable {
    
    public static func == (lhs: ToDoCategory, rhs: ToDoCategory) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
}
