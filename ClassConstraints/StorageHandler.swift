//
//  StorageHandler.swift
//  ClassConstraints
//
//  Created by cpsc on 11/1/20.
//

import Foundation

struct StorageHandler {
    static var defaultStorage: UserDefaults = UserDefaults.standard
    /*set and get settings*/
    static func getSetting(type: String) -> Bool {
        var settingBool: Bool
        if isSet(key: type) {
            settingBool = UserDefaults.standard.dictionaryRepresentation()[type] as! Bool
        } else {
            settingBool = true
        }
        return settingBool
    }
    static func setSetting(value: Bool, type: String) {
        defaultStorage.set(value, forKey:type)
    }
    
    static func getStorage() -> [[String]] {
        var taskArrays: [[String]]
        if isSet(key: "taskList") {
            taskArrays = UserDefaults.standard.dictionaryRepresentation()["taskList"] as! [[String]]
        } else {
            taskArrays = [[]]
        }
        return taskArrays
    }
    
    static func isSet(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
   
    static func setStorage(taskArrays: [[String]]) {
        defaultStorage.set(taskArrays, forKey:"taskList")
    }
    
    static func setAt(value: [String],index: Int) {
        var taskArrays: [[String]]
        
        if isSet(key: "taskList") {
            taskArrays = UserDefaults.standard.dictionaryRepresentation()["taskList"] as! [[String]]
            taskArrays[index] = value
        }
        else {
            taskArrays = [value]
        }
        defaultStorage.set(taskArrays, forKey: "taskList")
    }
    
    static func set(value: [String]) {
        var taskArrays: [[String]]
        
        if isSet(key: "taskList") {
            taskArrays = UserDefaults.standard.dictionaryRepresentation()["taskList"] as! [[String]]
            taskArrays.append(value)
        }
        else {
            taskArrays = [value]
        }
        defaultStorage.set(taskArrays, forKey: "taskList")
    }
    
    static func storageCount() -> Int {
        if isSet(key: "taskList") {
            let taskArrays: [[String]] = UserDefaults.standard.dictionaryRepresentation()["taskList"] as! [[String]]
            return taskArrays.count
        }
        return 0
    }
    static func remove(index: Int) {
        if isSet(key: "taskList") {
            var taskArray: [[String]] = UserDefaults.standard.dictionaryRepresentation()["taskList"] as! [[String]]
            taskArray.remove(at:index)
            
            defaultStorage.set(taskArray, forKey: "taskList")
        }
    }
    static func sort(col:Int) {
        if isSet(key: "taskList") {
            var taskArray: [[String]] = UserDefaults.standard.dictionaryRepresentation()["taskList"] as! [[String]]
            let count = taskArray.count
            quicksort(&taskArray, low:0, high: count-1, col:col)
            defaultStorage.set(taskArray, forKey: "taskList")
        }
    }
    
    static func quicksort(_ taskArray: inout [[String]],low:Int, high:Int,col: Int)
    {
        var num : Int
        if (low < high)
        {
            num = partition(&taskArray, low:low, high:high, col: col)
            
            quicksort(&taskArray, low:low, high:num-1, col: col)
            quicksort(&taskArray, low:num+1, high:high, col:col)
        }
    }


    static func partition(_ taskArray: inout [[String]],low:Int, high:Int, col:Int) -> Int
    {
        var pivot : String
        var i : Int
 
        pivot = taskArray[high][col]
        
        i = low - 1
        
        for j in low ..< high+1
        {
            let value = taskArray[j][col]
            var compare = value < pivot
            //check if date
            if (col == 1) {
                compare = getDate(str:value) < getDate(str:pivot)
                
            }
            if (compare)
            {
                i = i+1
                (taskArray[i], taskArray[j]) = (taskArray[j],taskArray[i])
            }
        }
        
        (taskArray[i+1], taskArray[high]) = (taskArray[high], taskArray[i+1])
        
        return i+1
    }
    static func getDate(str: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy, hh:mm a"
        let isoDate = "\(str)"
        let date = dateFormatter.date(from:isoDate) ?? NSDate(timeIntervalSinceNow: 60) as Date
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let foundDate = calendar.date(from:components)
        return foundDate!
    }
}
