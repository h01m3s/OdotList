//
//  Notification+Helper.swift
//  OdotList
//
//  Created by Weijie Lin on 5/14/18.
//  Copyright © 2018 Weijie Lin. All rights reserved.
//

import Foundation

extension Notification {
    struct UserInfoKey<ValueType>: Hashable {
        let key: String
    }
    
    func getUserInfo<T>(for key: Notification.UserInfoKey<T>) -> T {
        return userInfo![key] as! T
    }
}

extension Notification.Name {
    static let categoryStoreDidChangedNotification = Notification.Name(rawValue: "me.weijielin.OdotList.CategoryStoreDidChangedNotification")
}

extension Notification.UserInfoKey {
    static var cagetoryStoreDidChangedChangeBehaviorKey: Notification.UserInfoKey<CategoryStore.ChangeBehavior> {
        return Notification.UserInfoKey(key: "me.weijielin.OdotList.categoryStoreDidChangedNotification.ChangeBehavior")
    }
}

extension NotificationCenter {
    func post<T>(name aName: NSNotification.Name, object anObject: Any?, typedUserInfo aUserInfo: [Notification.UserInfoKey<T> : T]? = nil) {
        post(name: aName, object: anObject, userInfo: aUserInfo)
    }
}
