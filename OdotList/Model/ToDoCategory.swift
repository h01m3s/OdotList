//
//  ToDoCategory.swift
//  OdotList
//
//  Created by Weijie Lin on 5/8/18.
//  Copyright © 2018 Weijie Lin. All rights reserved.
//

import UIKit

struct ToDoCategory {
    
    // TODO: Simplify This
    
    typealias CategoryId = UUID
    
    var categoryName: String
    var categoryIcon: UIImage
    var categoryGradientColors: [UIColor]
    var categoryItems: [ToDoItem]
    let id: CategoryId
    var completedPercentage: Double {
        get {
            let completedTasks = categoryItems.filter { $0.isComplete == true }
            let percentage = Double(completedTasks.count) / Double(categoryItems.count)
            return percentage
        }
    }
    
    init(categoryName: String, categoryIcon: UIImage, categoryGradientColors: [UIColor], todoItems: [ToDoItem] = []) {
        self.id = CategoryId()
        self.categoryName = categoryName
        self.categoryIcon = categoryIcon
        self.categoryGradientColors = categoryGradientColors
        self.categoryItems = todoItems
    }
    
    mutating func edit(original: ToDoItem, new: ToDoItem) {
        guard let index = categoryItems.index(of: original) else { return }
        categoryItems[index] = new
    }
    
    mutating func delete(item: ToDoItem) {
        guard let index = categoryItems.index(of: item) else { return }
        categoryItems.remove(at: index)
    }
    
    mutating func append(item: ToDoItem) {
        categoryItems.append(item)
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
