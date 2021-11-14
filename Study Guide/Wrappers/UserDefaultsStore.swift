//
//  UserDefaults.swift
//  Study Guide
//
//  Created by Erick Sanchez on 11/1/21.
//

import Foundation

class UserDefaultsStore<T> {
    
    // TODO: Store key-value pairs
    func storeValue(key: String, value: T) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    // TODO: Read key-value pairs
    func read(fromKey key: String) -> T {
        return UserDefaults.standard.object(forKey: key) as! T
    }
    
    // TODO: Delete keys
    func delete(key: String){
        UserDefaults.standard.removeObject(forKey: key)
    }
}


