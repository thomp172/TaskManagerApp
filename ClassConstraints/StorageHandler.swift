//
//  StorageHandler.swift
//  ClassConstraints
//
//  Created by cpsc on 11/1/20.
//

import Foundation

struct StorageHandler {
    static var defaultStorage: UserDefaults = UserDefaults.standard
    
    static func getStorage() -> [[String]] {
        var colorArrays: [[String]]
        if isSet(key: "taskList") {
            colorArrays = UserDefaults.standard.dictionaryRepresentation()["taskList"] as! [[String]]
        } else {
            colorArrays = [[]]
        }
        return colorArrays
    }
    
    static func isSet(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
   
    
    static func set(value: [String]) {
        var colorArrays: [[String]]
        
        if isSet(key: "taskList") {
            colorArrays = UserDefaults.standard.dictionaryRepresentation()["taskList"] as! [[String]]
            colorArrays.append(value)
        }
        else {
            colorArrays = [value]
        }
        defaultStorage.set(colorArrays, forKey: "taskList")
    }
    
    static func storageCount() -> Int {
        if isSet(key: "taskList") {
            let colorArrays: [[String]] = UserDefaults.standard.dictionaryRepresentation()["taskList"] as! [[String]]
            return colorArrays.count
        }
        return 0
    }
}
