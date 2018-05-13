//
//  ToDoStore.swift
//  OdotList
//
//  Created by Weijie Lin on 5/12/18.
//  Copyright © 2018 Weijie Lin. All rights reserved.
//

import Foundation

class ToDoStore {
    
    enum ChangeBehavior {
        case add([Int])
        case remove([Int])
        case reload
    }
    
    private init() {}
    
    static let shared = ToDoStore()
    
}
