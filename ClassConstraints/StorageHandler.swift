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
        if isSet(key: "myNotes") {
            colorArrays = UserDefaults.standard.dictionaryRepresentation()["myNotes"] as! [[String]]
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
        
        if isSet(key: "myNotes") {
            colorArrays = UserDefaults.standard.dictionaryRepresentation()["myNotes"] as! [[String]]
            colorArrays.append(value)
        }
        else {
            colorArrays = [value]
        }
        defaultStorage.set(colorArrays, forKey: "myNotes")
    }
    
    static func storageCount() -> Int {
        if isSet(key: "myNotes") {
            let colorArrays: [[String]] = UserDefaults.standard.dictionaryRepresentation()["myNotes"] as! [[String]]
            return colorArrays.count
        }
        return 0
    }
}
