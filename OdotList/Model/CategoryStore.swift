//
//  ToDoStore.swift
//  OdotList
//
//  Created by Weijie Lin on 5/12/18.
//  Copyright © 2018 Weijie Lin. All rights reserved.
//

import Foundation

class CategoryStore {
    
    enum ChangeBehavior {
        case add([Int])
        case remove([Int])
        case reload
    }
    
    private init() {}
    
    static let shared = CategoryStore()
    
    private var categories: [ToDoCategory] = [] {
        didSet {
            let behavior = CategoryStore.diff(original: oldValue, now: categories)
            NotificationCenter.default.post(
                name: .categoryStoreDidChangedNotification,
                object: self,
                typedUserInfo: [.cagetoryStoreDidChangedChangeBehaviorKey: behavior]
            )
        }
    }
    
    static func diff(original: [ToDoCategory], now: [ToDoCategory]) -> ChangeBehavior {
        let originalSet = Set(original)
        let nowSet = Set(now)
        
        if originalSet.isSubset(of: nowSet) { // Appended
            let added = nowSet.subtracting(originalSet)
            let indexes = added.compactMap { now.index(of: $0) }
            return .add(indexes)
        } else if (nowSet.isSubset(of: originalSet)) { // Removed
            let removed = originalSet.subtracting(nowSet)
            let indexes = removed.compactMap { original.index(of: $0) }
            return .remove(indexes)
        } else { // Both appended and removed
            return .reload
        }
    }
    
    func append(category: ToDoCategory) {
        categories.append(category)
    }
    
    func append(newCategories: [ToDoCategory]) {
        categories.append(contentsOf: newCategories)
    }
    
    func remove(category: ToDoCategory) {
        guard let index = categories.index(of: category) else { return }
        remove(at: index)
    }
    
    func remove(at index: Int) {
        categories.remove(at: index)
    }
    
    func edit(original: ToDoCategory, new: ToDoCategory) {
        guard let index = categories.index(of: original) else { return }
        categories[index] = new
    }
    
    var count: Int {
        return categories.count
    }
    
    func item(at index: Int) -> ToDoCategory {
        return categories[index]
    }
    
    func itemCount(category: ToDoCategory) -> Int {
        guard let index = categories.index(of: category) else {
            print("error get item count")
            return  0
        }
        return categories[index].categoryItems.count
    }
    
    func categoryItems(category: ToDoCategory) -> [ToDoItem] {
        guard let index = categories.index(of: category) else { return [] }
        return categories[index].categoryItems
    }
    
    func removeItemFromCategory(category: ToDoCategory, item: ToDoItem) {
        guard let index = categories.index(of: category) else { return }
        categories[index].delete(item: item)
    }
    
    func updateCategory(category: ToDoCategory) -> ToDoCategory {
        guard let index = categories.index(of: category) else { fatalError("Unable to update category") }
        return categories[index]
    }
    
}
