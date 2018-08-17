//
//  ToDoItem.swift
//  OdotList
//
//  Created by Weijie Lin on 5/6/18.
//  Copyright © 2018 Weijie Lin. All rights reserved.
//

import Foundation

struct ToDoItem {
    
    enum ToDoPriority {
        case critical
        case important
        case normal
    }
    
    typealias ItemId = UUID
    
    let id: ItemId
    var title: String
    var isComplete: Bool = false
    let creationDate: TimeInterval
//    var note: String
//    var priority: ToDoPriority
//    var dueDate: TimeInterval?
    
//    init(title: String, note: String, priority: ToDoPriority = .normal, dueDate: TimeInterval? = nil) {
//        self.id = ItemId()
//        self.isComplete = false
//        self.title = title
//        self.creationDate = Date().timeIntervalSince1970
//        self.note = note
//        self.priority = priority
//        self.dueDate = dueDate
//    }
    
    init(title: String) {
        self.id = ItemId()
        self.title = title
        self.creationDate = Date().timeIntervalSince1970
    }
    
//    private enum CodingKeys: String, CodingKey {
//        case id
//        case title
//        case note
//        case priority
//        case dueDate
//        case creationDate
//    }

    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decode(UUID.self, forKey: .id)
//        title = try values.decode(String.self, forKey: .title)
//        note = try values.decode(String.self, forKey: .note)
//        priority = try values.decode(ToDoPriority.self, forKey: .priority)
//        dueDate = try values.decode(TimeInterval.self, forKey: .dueDate)
//        creationDate = try values.decode(TimeInterval.self, forKey: .dueDate)
//    }
}

extension ToDoItem: Hashable {
    var hashValue: Int {
        return id.hashValue
    }
}

extension ToDoItem: Equatable {
    public static func == (lhs: ToDoItem, rhs: ToDoItem) -> Bool {
        return lhs.id == rhs.id
    }
}
