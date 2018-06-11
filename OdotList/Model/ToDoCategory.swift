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
    var categoryGradientColors: [UIColor]
    var categoryItems: [ToDoItem]
    let id = UUID()
    var completedPercentage: Double {
        get {
            let completedTasks = categoryItems.filter { $0.isComplete == true }
            let percentage = Double(completedTasks.count) / Double(categoryItems.count)
            return percentage
        }
    }
    
    mutating func edit(original: ToDoItem, new: ToDoItem) {
        guard let index = categoryItems.index(of: original) else { return }
        categoryItems[index] = new
    }

}

extension ToDoCategory: Hashable {
    
    var hashValue: Int {
        return id.hashValue
    }
    
}

extension ToDoCategory: Equatable {
    
    public static func == (lhs: ToDoCategory, rhs: ToDoCategory) -> Bool {
        return lhs.id == rhs.id
    }
    
}
